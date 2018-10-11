Pod::Spec.new do |s|
  s.name             = 'ElanGridView'
  s.version          = '0.0.5'
  s.summary          = 'Simple Grid View in swift'

  s.description      = <<-DESC
	ElanGridview is an easy and simple GridView.
                       DESC

  s.homepage         = 'https://github.com/Elangr/ElanGridView.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Imrane EL HAMIANI' => 'i.elhamiani@elangr.com' }
  s.source           = { :git => 'https://github.com/Elangr/ElanGridView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ElanGridView/Classes/*.{h,m,swift}'

end
