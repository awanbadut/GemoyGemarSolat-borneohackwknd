import type { Request, Response } from "express";
import { prisma } from "../../lib/prisma";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

// --- REGISTER ---
export const register = async (req: Request, res: Response): Promise<any> => {
  try {
    const { username, email, password, role } = req.body;

    const existingUser = await prisma.user.findFirst({
      where: { OR: [{ email }, { username }] },
    });

    if (existingUser) {
      return res.status(400).json({
        success: false,
        message: "Username atau Email sudah terdaftar!",
      });
    }

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const newUser = await prisma.user.create({
      data: {
        username,
        email,
        password: hashedPassword,
        role: role || "LEARNER",
      },
    });

    return res.status(201).json({
      success: true,
      message: "Registrasi berhasil!",
      data: { id: newUser.id, username: newUser.username, role: newUser.role },
    });
  } catch (error: any) {
    return res.status(500).json({ success: false, error: error.message });
  }
};

// --- LOGIN ---
export const login = async (req: Request, res: Response): Promise<any> => {
  try {
    const { email, password } = req.body;

    // 1. Cari user berdasarkan email
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "User tidak ditemukan!" });
    }

    // 2. Cek kecocokan password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res
        .status(401)
        .json({ success: false, message: "Password salah!" });
    }

    // 3. Buat JWT Token
    const token = jwt.sign(
      { id: user.id, username: user.username, role: user.role },
      process.env.JWT_SECRET as string,
      { expiresIn: "7d" },
    );

    res.status(200).json({
      success: true,
      message: "Login sukses!",
      token,
      data: { id: user.id, username: user.username, role: user.role },
    });
  } catch (error: any) {
    return res.status(500).json({ success: false, error: error.message });
  }
};
