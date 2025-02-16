/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 1
/// Strings: 134
///
/// Built on 2024-10-21 at 05:32 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.vi;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.vi) // set locale
/// - Locale locale = AppLocale.vi.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.vi) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	vi(languageCode: 'vi', build: Translations.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of L).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = L.someKey.anotherKey;
/// String b = L['someKey.anotherKey']; // Only for edge cases!
Translations get L => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final L = Translations.of(context); // Get L variable.
/// String a = L.someKey.anotherKey; // Use L variable.
/// String b = L['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.L.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get L => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final L = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _LocalizationStringsAuthVi auth = _LocalizationStringsAuthVi._(_root);
	late final _LocalizationStringsCommonVi common = _LocalizationStringsCommonVi._(_root);
	late final _LocalizationStringsMoreVi more = _LocalizationStringsMoreVi._(_root);
}

// Path: auth
class _LocalizationStringsAuthVi {
	_LocalizationStringsAuthVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get nameApp => 'KMAD User Career';
	String get textFieldEmailTitle => 'Email';
	String get textFieldEmailHint => 'Vui lòng nhập';
	String get textFieldPasswordTitle => 'Mật khẩu';
	String get textFieldPasswordHint => 'Vui lòng nhập';
	String get textButtonForgotPasswordText => 'Quên mật khẩu?';
	String get buttonSignInText => 'Đăng nhập';
	String get textPageTitleResetPasswordPage => 'Quên mật khẩu';
	String get textPageContentResetPasswordPage => 'Nhập email để đặt lại mật khẩu';
	String get textFieldNewPasswordTitle => 'Mật khẩu mới';
	String get textFieldNewPasswordHint => 'Vui lòng nhập';
	String get textFieldConfirmPasswordTitle => 'Nhập lại mật khẩu này';
	String get textFieldConfirmPasswordHint => 'Vui lòng nhập';
	String get buttonResetPasswordText => 'Đặt lại mật khẩu';
	String get textPageTitleVerifyPage => 'Nhập mã xác thực';
	String get textPageContentVerifyPage => 'Mã xác thực 6 số đã được gửi tới ';
	String get textPageContentTimeVerifyPage => 'Mã có hiệu lực trong 5 phút.';
	String get textQuestionConfirmEmail => 'Chưa nhận được email?';
	String get textButtonResendEmailText => 'Gửi lại email';
	String get buttonConfirmText => 'Xác nhận';
	String get textPageTitleUpdatePasswordPage => 'Đặt lại mật khẩu mới';
	String get textPageContentUpdatePasswordPage => 'Đặt mật khẩu mới. Đảm bảo mật khẩu mới khác với mật khẩu trước đó';
	String get buttonUpdatePasswordText => 'Cập nhật mật khẩu';
	String get textPageTitleSuccessfulPage => 'Thành công';
	String get textPageContentSuccessfulPage => 'Thành công! Mật khẩu đã được thay đổi.\nClick “Tiếp tục" để đăng nhập.';
	String get buttonNextText => 'Tiếp tục';
	String get signInSuccessfulText => 'Đăng nhập thành công';
	String get signInIdSuccessfulText => 'Cập nhật ID cửa hàng thành công';
	String get sendMailVerifySuccessfulText => 'Gửi mã xác thực thành công';
	String get sendVerifyCodeSuccessfulText => 'Xác thực thành công';
	String get resetPasswordSuccessfulText => 'Đặt lại mật khẩu thành công';
	String get textMessageRegister => 'Bạn chưa có tài khoản?';
	String get textButtonRegister => 'Đăng ký';
	String get textErrorEmptyData => 'Nhập đủ thông tin';
	String get textRegisterSuccessful => 'Đăng ký thành công';
}

// Path: common
class _LocalizationStringsCommonVi {
	_LocalizationStringsCommonVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _LocalizationStringsCommonTabBarVi tabBar = _LocalizationStringsCommonTabBarVi._(_root);
	late final _LocalizationStringsCommonBaseUploadAvatarViewVi baseUploadAvatarView = _LocalizationStringsCommonBaseUploadAvatarViewVi._(_root);
	String get errorCheckEmail => 'Email không đúng định dạng';
	String get errorCheckPassword => 'Vui lòng nhập Mật khẩu';
	String get errorCallPhone => 'Không thể gọi số điện thoại';
	String get errorCheckNewPassword => 'Mật khẩu tối thiểu 9 ký tự';
	String get errorCheckConfirmPassword => 'Mật khẩu không trùng khớp';
	String get noPermission => 'Không có quyền xem nội dung này';
	String get emptyList => 'Không có kết quả phù hợp';
	String get refreshText => 'Làm mới';
	String get titleSelectBranch => 'Chọn chi nhánh';
	String get emptyNotification => 'Bạn chưa có thông báo nào';
}

// Path: more
class _LocalizationStringsMoreVi {
	_LocalizationStringsMoreVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get bottomSheetTitle => 'Thời gian';
	String get bottomSheetToday => 'Hôm nay';
	String get bottomSheetYesterday => 'Hôm qua';
	String get bottomSheetLastSevenDays => '7 ngày qua';
	String get bottomSheetThisMonth => 'Tháng này';
	String get bottomSheetLastMonth => 'Tháng trước';
	String get bottomSheetCustomDay => 'Tùy chỉnh';
	String get bottomSheetCalanderStartdate => 'Từ ngày';
	String get bottomSheetCalanderEnddate => 'Đến ngày';
	String get bottomSheetCalanderButtonReturn => 'Quay lại';
	String get bottomSheetCalanderButtonApply => 'Áp dụng';
	String get statusServiceWaiting => 'Chờ xác nhận';
	String get statusServiceConfirmed => 'Đã xác nhận';
	String get statusServiceHappened => 'Đã diễn ra';
	String get statusServiceDone => 'Hoàn chỉnh';
	String get changePassword => 'Đổi mật khẩu';
	String get logout => 'Đăng xuất';
	String get cancel => 'Hủy';
	String get youDefinitelyWantToSignOut => ' Bạn chắc chắn muốn đăng xuất';
	String get changePasswordTitle => 'Thay đổi mật khẩu';
	String get changePasswordHintText => 'Vui lòng nhập';
	String get changePasswordOld => 'Mật khẩu cũ';
	String get changePasswordNew => 'Mật khẩu mới';
	String get changePasswordEnter => 'Nhập lại mật khẩu';
	String get changePasswordButton => 'Cập nhật mật khẩu';
	String get messageChangeSuccessful => 'Cập nhật thành công';
	String get errorEmpty => 'Nhập đủ thông tin';
	String get errorIsOldPassword => 'Trùng mật khẩu cũ';
	String get errorIsNewPassword => 'Không giống mật khẩu mới';
	String get errorIsStrongPassword => 'Mật khẩu yếu';
	String get expectTitle => 'Hồ sơ chuyên gia';
	String get expectTextButton => 'Lưu';
	String get expectAskCommunicate => 'Bạn có thể nói được ngôn ngữ nào?';
	String get expectAskCommunicateHint => 'Ngôn ngữ';
	String get expectAskYearOfExperience => 'Số năm kinh nghiệm?';
	String get expectAskSkill => 'Giới thiệu về kinh nghiệm và kỹ năng?';
	String get expectListTileExperiences => 'Kinh nghiệm';
	String get expectListTileSkills => 'Kỹ năng';
	String get expectListTileCertificates => 'Bằng cấp';
	String get expectListTilePrice => 'Giá dịch vụ tư vấn';
	String get inforTitle => 'Thông tin cá nhân';
	String get inforTextFieldTitleName => 'Tên';
	String get inforTextFieldTitleEmail => 'Email';
	String get inforTextFieldTitlePhone => 'Số điện thoại';
	String get inforTextFieldTitleAddress => 'Nơi ở';
	String get inforTextFieldPlaceholderName => 'Họ và tên';
	String get inforTextFieldPlaceholderEmail => 'Tài khoản Email';
	String get inforTextFieldPlaceholderAddress => 'Địa chỉ';
	String get inforTextButton => 'Cập nhật thông tin';
	String get inforMessageSuccess => 'Cập nhật thành công!';
	String get addExperienceTitle => 'Thêm kinh nghiệm';
	String get addExperienceTextButton => 'Lưu';
	String get addExperienceTextFieldCompany => 'Công ty';
	String get addExperienceTextFieldPosition => 'Chức vụ';
	String get addExperienceTextFieldStartDate => 'Ngày bắt đầu';
	String get addExperienceTextFieldEndDate => 'Ngày kết thúc';
	String get addExperienceTextFieldDescription => 'Mô tả công việc';
	String get addExperienceTextFieldCategory => 'Chuyên ngành';
	String get addExperienceAskWorkHere => 'Bạn có đang làm việc tại đây không?';
	String get addExperienceSuccess => 'Thêm kinh nghiệm thành công';
	String get editExperienceTitle => 'Chỉnh sửa kinh nghiệm';
	late final _LocalizationStringsMorePriceServiceVi priceService = _LocalizationStringsMorePriceServiceVi._(_root);
	String get textMyCalendar => 'Lịch tư vấn';
	String get textMyWallet => 'Ví của tôi';
	String get manageServiceTitle => 'Quản lý dịch vụ';
	String get manageServiceSeeAll => 'Xem tất cả';
	String get manageServiceStatusWaiting => 'Chờ xác nhận';
	String get manageServiceStatusConfirmed => 'Đã xác nhận';
	String get manageServiceStatusHappened => 'Đã diễn ra';
	String get manageServiceStatusDone => 'Hoàn thành';
	String get manageServiceStatusCancel => 'Hủy';
	String get errorInvalidMessage => 'Không hợp lệ!';
}

// Path: common.tabBar
class _LocalizationStringsCommonTabBarVi {
	_LocalizationStringsCommonTabBarVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get home => 'Trang chủ';
	String get request => 'Yêu cầu';
	String get message => 'Tin nhắn';
	String get more => 'Tài khoản';
}

// Path: common.baseUploadAvatarView
class _LocalizationStringsCommonBaseUploadAvatarViewVi {
	_LocalizationStringsCommonBaseUploadAvatarViewVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get delete => 'Xóa';
	String get capture => 'Camera';
	String get pickImage => 'Thư viện';
}

// Path: more.priceService
class _LocalizationStringsMorePriceServiceVi {
	_LocalizationStringsMorePriceServiceVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get serviceCallPrice => 'Giá dịch vụ gọi điện :';
	String get call => 'Gọi điện';
	String get callPrice => 'Giá gọi điện';
	String get serviceDirectPrice => 'Giá dịch vụ trực tiếp :';
	String get direct => 'Trực tiếp';
	String get directPrice => 'Giá trực tiếp';
	String get minute => 'Phút';
	String get currencyVnd => 'VND';
	String get consultationTime => 'Thời gian tư vấn';
	String get dayOfWeek => 'Thứ :';
	String get timeFrame => 'Khung giờ :';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.nameApp': return 'KMAD User Career';
			case 'auth.textFieldEmailTitle': return 'Email';
			case 'auth.textFieldEmailHint': return 'Vui lòng nhập';
			case 'auth.textFieldPasswordTitle': return 'Mật khẩu';
			case 'auth.textFieldPasswordHint': return 'Vui lòng nhập';
			case 'auth.textButtonForgotPasswordText': return 'Quên mật khẩu?';
			case 'auth.buttonSignInText': return 'Đăng nhập';
			case 'auth.textPageTitleResetPasswordPage': return 'Quên mật khẩu';
			case 'auth.textPageContentResetPasswordPage': return 'Nhập email để đặt lại mật khẩu';
			case 'auth.textFieldNewPasswordTitle': return 'Mật khẩu mới';
			case 'auth.textFieldNewPasswordHint': return 'Vui lòng nhập';
			case 'auth.textFieldConfirmPasswordTitle': return 'Nhập lại mật khẩu này';
			case 'auth.textFieldConfirmPasswordHint': return 'Vui lòng nhập';
			case 'auth.buttonResetPasswordText': return 'Đặt lại mật khẩu';
			case 'auth.textPageTitleVerifyPage': return 'Nhập mã xác thực';
			case 'auth.textPageContentVerifyPage': return 'Mã xác thực 6 số đã được gửi tới ';
			case 'auth.textPageContentTimeVerifyPage': return 'Mã có hiệu lực trong 5 phút.';
			case 'auth.textQuestionConfirmEmail': return 'Chưa nhận được email?';
			case 'auth.textButtonResendEmailText': return 'Gửi lại email';
			case 'auth.buttonConfirmText': return 'Xác nhận';
			case 'auth.textPageTitleUpdatePasswordPage': return 'Đặt lại mật khẩu mới';
			case 'auth.textPageContentUpdatePasswordPage': return 'Đặt mật khẩu mới. Đảm bảo mật khẩu mới khác với mật khẩu trước đó';
			case 'auth.buttonUpdatePasswordText': return 'Cập nhật mật khẩu';
			case 'auth.textPageTitleSuccessfulPage': return 'Thành công';
			case 'auth.textPageContentSuccessfulPage': return 'Thành công! Mật khẩu đã được thay đổi.\nClick “Tiếp tục" để đăng nhập.';
			case 'auth.buttonNextText': return 'Tiếp tục';
			case 'auth.signInSuccessfulText': return 'Đăng nhập thành công';
			case 'auth.signInIdSuccessfulText': return 'Cập nhật ID cửa hàng thành công';
			case 'auth.sendMailVerifySuccessfulText': return 'Gửi mã xác thực thành công';
			case 'auth.sendVerifyCodeSuccessfulText': return 'Xác thực thành công';
			case 'auth.resetPasswordSuccessfulText': return 'Đặt lại mật khẩu thành công';
			case 'auth.textMessageRegister': return 'Bạn chưa có tài khoản?';
			case 'auth.textButtonRegister': return 'Đăng ký';
			case 'auth.textErrorEmptyData': return 'Nhập đủ thông tin';
			case 'auth.textRegisterSuccessful': return 'Đăng ký thành công';
			case 'common.tabBar.home': return 'Trang chủ';
			case 'common.tabBar.request': return 'Yêu cầu';
			case 'common.tabBar.message': return 'Tin nhắn';
			case 'common.tabBar.more': return 'Tài khoản';
			case 'common.baseUploadAvatarView.delete': return 'Xóa';
			case 'common.baseUploadAvatarView.capture': return 'Camera';
			case 'common.baseUploadAvatarView.pickImage': return 'Thư viện';
			case 'common.errorCheckEmail': return 'Email không đúng định dạng';
			case 'common.errorCheckPassword': return 'Vui lòng nhập Mật khẩu';
			case 'common.errorCallPhone': return 'Không thể gọi số điện thoại';
			case 'common.errorCheckNewPassword': return 'Mật khẩu tối thiểu 9 ký tự';
			case 'common.errorCheckConfirmPassword': return 'Mật khẩu không trùng khớp';
			case 'common.noPermission': return 'Không có quyền xem nội dung này';
			case 'common.emptyList': return 'Không có kết quả phù hợp';
			case 'common.refreshText': return 'Làm mới';
			case 'common.titleSelectBranch': return 'Chọn chi nhánh';
			case 'common.emptyNotification': return 'Bạn chưa có thông báo nào';
			case 'more.bottomSheetTitle': return 'Thời gian';
			case 'more.bottomSheetToday': return 'Hôm nay';
			case 'more.bottomSheetYesterday': return 'Hôm qua';
			case 'more.bottomSheetLastSevenDays': return '7 ngày qua';
			case 'more.bottomSheetThisMonth': return 'Tháng này';
			case 'more.bottomSheetLastMonth': return 'Tháng trước';
			case 'more.bottomSheetCustomDay': return 'Tùy chỉnh';
			case 'more.bottomSheetCalanderStartdate': return 'Từ ngày';
			case 'more.bottomSheetCalanderEnddate': return 'Đến ngày';
			case 'more.bottomSheetCalanderButtonReturn': return 'Quay lại';
			case 'more.bottomSheetCalanderButtonApply': return 'Áp dụng';
			case 'more.statusServiceWaiting': return 'Chờ xác nhận';
			case 'more.statusServiceConfirmed': return 'Đã xác nhận';
			case 'more.statusServiceHappened': return 'Đã diễn ra';
			case 'more.statusServiceDone': return 'Hoàn chỉnh';
			case 'more.changePassword': return 'Đổi mật khẩu';
			case 'more.logout': return 'Đăng xuất';
			case 'more.cancel': return 'Hủy';
			case 'more.youDefinitelyWantToSignOut': return ' Bạn chắc chắn muốn đăng xuất';
			case 'more.changePasswordTitle': return 'Thay đổi mật khẩu';
			case 'more.changePasswordHintText': return 'Vui lòng nhập';
			case 'more.changePasswordOld': return 'Mật khẩu cũ';
			case 'more.changePasswordNew': return 'Mật khẩu mới';
			case 'more.changePasswordEnter': return 'Nhập lại mật khẩu';
			case 'more.changePasswordButton': return 'Cập nhật mật khẩu';
			case 'more.messageChangeSuccessful': return 'Cập nhật thành công';
			case 'more.errorEmpty': return 'Nhập đủ thông tin';
			case 'more.errorIsOldPassword': return 'Trùng mật khẩu cũ';
			case 'more.errorIsNewPassword': return 'Không giống mật khẩu mới';
			case 'more.errorIsStrongPassword': return 'Mật khẩu yếu';
			case 'more.expectTitle': return 'Hồ sơ chuyên gia';
			case 'more.expectTextButton': return 'Lưu';
			case 'more.expectAskCommunicate': return 'Bạn có thể nói được ngôn ngữ nào?';
			case 'more.expectAskCommunicateHint': return 'Ngôn ngữ';
			case 'more.expectAskYearOfExperience': return 'Số năm kinh nghiệm?';
			case 'more.expectAskSkill': return 'Giới thiệu về kinh nghiệm và kỹ năng?';
			case 'more.expectListTileExperiences': return 'Kinh nghiệm';
			case 'more.expectListTileSkills': return 'Kỹ năng';
			case 'more.expectListTileCertificates': return 'Bằng cấp';
			case 'more.expectListTilePrice': return 'Giá dịch vụ tư vấn';
			case 'more.inforTitle': return 'Thông tin cá nhân';
			case 'more.inforTextFieldTitleName': return 'Tên';
			case 'more.inforTextFieldTitleEmail': return 'Email';
			case 'more.inforTextFieldTitlePhone': return 'Số điện thoại';
			case 'more.inforTextFieldTitleAddress': return 'Nơi ở';
			case 'more.inforTextFieldPlaceholderName': return 'Họ và tên';
			case 'more.inforTextFieldPlaceholderEmail': return 'Tài khoản Email';
			case 'more.inforTextFieldPlaceholderAddress': return 'Địa chỉ';
			case 'more.inforTextButton': return 'Cập nhật thông tin';
			case 'more.inforMessageSuccess': return 'Cập nhật thành công!';
			case 'more.addExperienceTitle': return 'Thêm kinh nghiệm';
			case 'more.addExperienceTextButton': return 'Lưu';
			case 'more.addExperienceTextFieldCompany': return 'Công ty';
			case 'more.addExperienceTextFieldPosition': return 'Chức vụ';
			case 'more.addExperienceTextFieldStartDate': return 'Ngày bắt đầu';
			case 'more.addExperienceTextFieldEndDate': return 'Ngày kết thúc';
			case 'more.addExperienceTextFieldDescription': return 'Mô tả công việc';
			case 'more.addExperienceTextFieldCategory': return 'Chuyên ngành';
			case 'more.addExperienceAskWorkHere': return 'Bạn có đang làm việc tại đây không?';
			case 'more.addExperienceSuccess': return 'Thêm kinh nghiệm thành công';
			case 'more.editExperienceTitle': return 'Chỉnh sửa kinh nghiệm';
			case 'more.priceService.serviceCallPrice': return 'Giá dịch vụ gọi điện :';
			case 'more.priceService.call': return 'Gọi điện';
			case 'more.priceService.callPrice': return 'Giá gọi điện';
			case 'more.priceService.serviceDirectPrice': return 'Giá dịch vụ trực tiếp :';
			case 'more.priceService.direct': return 'Trực tiếp';
			case 'more.priceService.directPrice': return 'Giá trực tiếp';
			case 'more.priceService.minute': return 'Phút';
			case 'more.priceService.currencyVnd': return 'VND';
			case 'more.priceService.consultationTime': return 'Thời gian tư vấn';
			case 'more.priceService.dayOfWeek': return 'Thứ :';
			case 'more.priceService.timeFrame': return 'Khung giờ :';
			case 'more.textMyCalendar': return 'Lịch tư vấn';
			case 'more.textMyWallet': return 'Ví của tôi';
			case 'more.manageServiceTitle': return 'Quản lý dịch vụ';
			case 'more.manageServiceSeeAll': return 'Xem tất cả';
			case 'more.manageServiceStatusWaiting': return 'Chờ xác nhận';
			case 'more.manageServiceStatusConfirmed': return 'Đã xác nhận';
			case 'more.manageServiceStatusHappened': return 'Đã diễn ra';
			case 'more.manageServiceStatusDone': return 'Hoàn thành';
			case 'more.manageServiceStatusCancel': return 'Hủy';
			case 'more.errorInvalidMessage': return 'Không hợp lệ!';
			default: return null;
		}
	}
}
