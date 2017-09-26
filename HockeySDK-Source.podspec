Pod::Spec.new do |s|
  s.name              = 'HockeySDK-Source'
  s.version           = '5.0.0'

  s.summary           = 'Collect live crash reports, get feedback from your users, distribute your betas, and analyze your test coverage with HockeyApp.'
  s.description       = <<-DESC
                        HockeyApp is a service to distribute beta apps, collect crash reports and
                        communicate with your app's users.

                        It improves the testing process dramatically and can be used for both beta
                        and App Store builds.
                        DESC

  s.homepage          = 'http://hockeyapp.net/'
  s.documentation_url = "http://hockeyapp.net/help/sdk/ios/#{s.version}/"

  s.license           = 'MIT'
  s.author            = { 'Microsoft' => 'support@hockeyapp.net' }
  s.source            = { :git => 'https://github.com/bitstadium/HockeySDK-iOS.git', :tag => s.version.to_s }

  s.platform          = :ios, '8.0'
  s.requires_arc      = true

  s.default_subspec = 'DefaultLib'

  s.subspec 'Core' do |ss|
      ss.source_files         = 'Classes'
      ss.libraries            = 'c++', 'z'
      ss.vendored_frameworks  = 'Vendor/CrashReporter.framework'
      ss.resource_bundle      = { 'HockeySDKResources' => ['Resources/*.png', 'Resources/*.lproj'] }
      ss.preserve_paths       = 'Resources', 'Support'
      ss.private_header_files = 'Classes/*Private.h'
      ss.frameworks           = 'Foundation', 'Security', 'SystemConfiguration', 'UIKit'
  end

  s.subspec 'CrashOnlyLib' do |ss|
    ss.dependency 'HockeySDK-Source/Core'
    ss.pod_target_xcconfig  = {'GCC_PREPROCESSOR_DEFINITIONS' => %{$(inherited) BITHOCKEY_VERSION="@\\"#{s.version}\\"" BITHOCKEY_C_VERSION="\\"#{s.version}\\"" BITHOCKEY_BUILD="@\\"104\\"" BITHOCKEY_C_BUILD="\\"104\\"" HOCKEYSDK_FEATURE_CRASH_REPORTER=1 HOCKEYSDK_FEATURE_FEEDBACK=0 HOCKEYSDK_FEATURE_STORE_UPDATES=0 HOCKEYSDK_FEATURE_AUTHENTICATOR=0 HOCKEYSDK_FEATURE_UPDATES=0 HOCKEYSDK_FEATURE_METRICS=1} }
  end

  s.subspec 'DefaultLib' do |ss|
    ss.dependency 'HockeySDK-Source/Core'
    ss.frameworks           = 'AssetsLibrary', 'CoreGraphics', 'CoreText', 'CoreTelephony', 'MobileCoreServices', 'QuartzCore', 'QuickLook'
    ss.pod_target_xcconfig  = {'GCC_PREPROCESSOR_DEFINITIONS' => %{$(inherited) BITHOCKEY_VERSION="@\\"#{s.version}\\"" BITHOCKEY_C_VERSION="\\"#{s.version}\\"" BITHOCKEY_BUILD="@\\"104\\"" BITHOCKEY_C_BUILD="\\"104\\"" HOCKEYSDK_FEATURE_CRASH_REPORTER=1 HOCKEYSDK_FEATURE_FEEDBACK=0 HOCKEYSDK_FEATURE_STORE_UPDATES=1 HOCKEYSDK_FEATURE_AUTHENTICATOR=1 HOCKEYSDK_FEATURE_UPDATES=1 HOCKEYSDK_FEATURE_METRICS=1} }
  end

  s.subspec 'AllFeaturesLib' do |ss|
    ss.dependency 'HockeySDK-Source/Core'
    ss.frameworks           = 'AssetsLibrary', 'CoreGraphics', 'CoreText', 'CoreTelephony', 'MobileCoreServices', 'Photos', 'QuartzCore', 'QuickLook'
    ss.pod_target_xcconfig  = {'GCC_PREPROCESSOR_DEFINITIONS' => %{$(inherited) BITHOCKEY_VERSION="@\\"#{s.version}\\"" BITHOCKEY_C_VERSION="\\"#{s.version}\\"" BITHOCKEY_BUILD="@\\"104\\"" BITHOCKEY_C_BUILD="\\"104\\"" HOCKEYSDK_FEATURE_CRASH_REPORTER=1 HOCKEYSDK_FEATURE_FEEDBACK=1 HOCKEYSDK_FEATURE_STORE_UPDATES=1 HOCKEYSDK_FEATURE_AUTHENTICATOR=1 HOCKEYSDK_FEATURE_UPDATES=1 HOCKEYSDK_FEATURE_METRICS=1} }
  end

end
