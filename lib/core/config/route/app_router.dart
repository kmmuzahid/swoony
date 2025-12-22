import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'app_router.gr.dart';

final GlobalKey<NavigatorState> navigatorRouterKey = GlobalKey<NavigatorState>();

final appRouter = AppRouter();

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    /**
     * if(language is not slected then onboard){
     *   appRouter.replace(OnboardingRoute());
     *   return;
     * }
     * 
     * if(is not login){
     *   appRouter.replace(SignInOptionRoute());
     *   return;
     * }
     * 
     * if(login){
     *   appRouter.replace(HomeRoute());
     *   resolver.next();
     * return;
     * }
     */

    resolver.next();
  }
}

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter() : super(navigatorKey: navigatorRouterKey);
  @override
  List<AutoRouteGuard> get guards => [AuthGuard()];

@override
RouteType get defaultRouteType => const RouteType.cupertino();


  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: ForgetPasswordRoute.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: SettingRoute.page),
    AutoRoute(page: TermsConditionRoute.page),
    AutoRoute(page: PrivacyPolicyRoute.page),
    AutoRoute(page: ProfileInfoRoute.page),
    AutoRoute(page: ChatListRoute.page),
    AutoRoute(page: NotificationRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ShowInfoRoute.page),
    AutoRoute(page: AllEventRoute.page),
    AutoRoute(page: EventDetailsRoute.page),
    AutoRoute(page: EmailPreferenceRoute.page),
    AutoRoute(page: ContactUsRoute.page),
    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: TicketsRoute.page),
    AutoRoute(page: EventNotificationEnableRoute.page),
    AutoRoute(page: CreateEventRoute.page),
    AutoRoute(page: LocationRoute.page),
    AutoRoute(page: CustomMapRoute.page),
    AutoRoute(page: FaqRoute.page),
    AutoRoute(page: PaymentWebView.page),
  ];
}
