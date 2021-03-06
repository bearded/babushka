dep 'curl.bin'

dep 'gettext.lib'

dep 'nodejs.bin' do
  installs {
    # The 'nodejs-legacy' package symlinks the renamed 'nodejs' binary back
    # into place as 'node'.
    on :trusty, 'nodejs', 'nodejs-dev', 'nodejs-legacy'
    via :apt, 'nodejs', 'nodejs-dev'
    via :zypper, 'nodejs', 'nodejs-devel'
    via :brew, 'node'
    via :freebsd, 'node'
    otherwise 'nodejs'
  }
  provides 'node >= 0.6.12'
  after {
    # Trigger the creation of npm's global package dir, which it can't run
    # without. (Only newer nodes bundle npm, though.)
    shell!('npm --version') if which('npm')
  }
end

dep 'sudo.bin'
