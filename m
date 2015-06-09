MIME-Version: 1.0
Date: Tue, 9 Jun 2015 02:49:21 -0300
Message-ID: <CAKi4VAKaZPtGvT9gwTOmoTG8mpnn05ybSSeNde8VPOcczLuChg@mail.gmail.com>
Subject: [ANNOUNCE] kmod 21
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

kmod 21 is out:

        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-21.tar.xz
        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-21.tar.sign

Small release with just 3 changes worth mentioning. From the NEWS file:

- New features:
        - kmod tool started to learn the "insert" and "remove" commands that
          are the simplified versions of the older modprobe tool.  These
          commands are still work in progress so they are hidden behind a
          --enable-experimental flag during build.  It should not be enabled
          unless you know what you're doing.
        - kmod tool now prints the relevant configuration options it was built
          with when the "--version" argument is passed. This helps to mitigate
          problems for example when the user is trying to load a compressed
          module but kmod was built without support for the compression method.

- Improvements to testsuite:
        - Cache built modules so it is easier to run "make check" on build
          servers by distro maintainers. If kmod is configured with
          --disable-test-modules the modules from cache will be used by
          "make check". No changes to the tests are needed and all of them
          can run fine.

Shortlog:

Lucas De Marchi <lucas.demarchi@intel.com> (12):
      build: use dolt
      build: sync dolt with upstream
      util: use UINT64_MAX
      build: cache modules from playground
      tools: Hide new commands behind experimental flag
      tools: add PACKAGE definition in message
      build: add function to build string of features
      build: add relevant features to KMOD_FEATURES in config.h
      tools: display features in --version
      build: silence stderr on coverity rules
      build: add cache to distributed files
      kmod 21

Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com> (3):
      testsuite: remove .gitignore files when populating rootfs
      testsuite: update README
      tools: add basic versions of insert and remove

Santiago Vila <sanvila@unex.es> (2):
      Fix spurious spaces in lsmod output
      kmod: fix small typo in rmmod(8)

-- 
Lucas De Marchi
