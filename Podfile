# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Marvel' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Marvel

  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'

end


post_install do |installer|
	installer.pods_project.targets.each do |target|
		if target.name == 'RxSwift'
			target.build_configurations.each do |config|
				if config.name == 'Debug'
					config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D',
					'TRACE_RESOURCES']
				end
			end
		end
	end
end
