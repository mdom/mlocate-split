use Module::Build;
Module::Build->new(
    module_name => 'App::mlocate-split',
    license     => 'perl',
    requires    => {
        'Getopt::Long'   => '0',
        'Pod::Usage'     => '0',
        'Cwd'            => '0',
        'File::Basename' => '0',
        'English'        => '0',
    },
    dist_version_from  => 'bin/mlocate-split',
    create_makefile_pl => 'passthrough',
)->create_build_script;

