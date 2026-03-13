class AppAssets {
  AppAssets._();

  // Base path
  static const _base = 'assets/asset';

  // ===== MASKOT =====
  static const String welcome = '$_base/maskot/welcome.png';
  static const maskotWelcome = '$_base/maskot/welcome.png';
  static const maskotLompat = '$_base/maskot/lompat.gif';
  static const onboard1 = '$_base/maskot/onboard 1.png';
  static const onboard2 = '$_base/maskot/onboard 2.png';
  static const onboard3 = '$_base/maskot/onoard 3.png';
  static const binggung = '$_base/maskot/binggung.png';
  static const tunjuk = '$_base/maskot/tunjuk.png';

  // ===== PET KABAU STAGES =====
  static const petEgg = '$_base/pet/kabau telur no bg.png';
  static const petEggBg = '$_base/pet/kabau telur.png';
  static const petBaby = '$_base/pet/kabau anak no bg.png';
  static const petBabyBg = '$_base/pet/kabau anak.png';
  static const petTeen = '$_base/pet/kabau remaja no bg.png';
  static const petTeenBg = '$_base/pet/kabau remaja.png';
  static const petAdult = '$_base/pet/kabau dewasa no bg.png';
  static const petAdultBg = '$_base/pet/kabau dewasa.png';
  static const petMaster = '$_base/pet/kabau.png';
  static const petDefault = '$_base/pet/default.png';
  static const petBurung = '$_base/pet/burung.png';
  static const petOrangUtanAnak = '$_base/pet/orang utan anak.png';
  static const petOrangUtanAnaknobg = '$_base/pet/orang utan anak no bg.png';
  static const petOrangUtanRemaja = '$_base/pet/orang utan remaja no bg.png';
  static const petOrangUtanDewasa = '$_base/pet/orang utan dewasa no bg.png';
  static const petKucing = '$_base/pet/kucing.png';
  static const defaultAvatar = '$_base/avatar/avatar_default.png';

  // ===== FLAGS =====
  static const flagBrunei = '$_base/flag/brunei.png';
  static const flagFilipina = '$_base/flag/filipina.png';
  static const flagIndonesia = '$_base/flag/indonesia.png';
  static const flagKamboja = '$_base/flag/kamboja.png';
  static const flagLaos = '$_base/flag/laos.png';
  static const flagMalaysia = '$_base/flag/malaysia.png';
  static const flagMyanmar = '$_base/flag/myanmar.png';
  static const flagSingapure = '$_base/flag/singapure.png';
  static const flagThailand = '$_base/flag/thailand.png';
  static const flagTimurLeste = '$_base/flag/timur leste.png';
  static const flagVietnam = '$_base/flag/vietnam.png';

  // Helper: Get pet image by stage
  static String getPetByStage(int phrases) {
    if (phrases < 100) return petEgg;
    if (phrases < 500) return petBaby;
    if (phrases < 2000) return petTeen;
    if (phrases < 5000) return petAdult;
    return petMaster;
  }
}
