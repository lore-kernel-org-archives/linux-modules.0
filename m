MIME-Version: 1.0
Date: Sun, 1 Mar 2015 16:07:44 -0300
Message-ID: <CAKi4VA+PX27mzxAmjx_O6YnRzEWqfAcyVRBKnuaOO=+VUZ0yVg@mail.gmail.com>
Subject: [ANNOUNCE] kmod 20
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

kmod 20 is out:

        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-20.tar.xz
        ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-20.tar.sign

Most visible change is a change in behavior regarding builtin modules.
See the "New features" item below.

Measuring by commit count this is the biggest release since kmod-2!
However most of it was due to improvements to the testsuite. In the
beginning of this year I received complaints that kmod was shipping
prebuilt GPL modules without distributing their source code. This
happened because in order to test real world modules, I was taking any
problematic module, putting it into the testsuite and writing tests
for them. All the modules were GPL, coming from the kernel itself. Due
to modversions I could even pinpoint the exact kernel version, but
maybe this would not be sufficient for Debian. Instead of going this
route, I decided to improve the testsuite, creating a
"module-playground" in which we build our own modules tailored to the
specific test. Some tests were rewritten, too.  Now the only prebuilt
modules we are shipping are the ones for different architectures since
it would be too inconvenient to require cross-compilers on distro's
build machines. But even those have rules in the build system to be
recreated from source. For distros, what changes is that you need the
kernel headers installed in order to run "make check".

NEWS.

- Bug fixes:
        - Handle bogus values from ELF, making sure they don't overflow whi=
le
          parsing the file
        - Fix leak in depmod when -b flag is passed multiple times
        - Multiple minor fixes from static analysis by coverity and
          clang-analyze
        - Fix race between loading modules and checking if it's loaded in t=
he
          kernel

- New features:
        - There's a change in behavior regarding builtin modules: we now on=
ly
          consider as builtin those that are present in modules.builtin ind=
ex.
          Previously we were also checking the presence of
          /sys/module/<module-name>, but this is racy and only modules that
          contain parameters are the ones creating a directory in sysfs.

          Now some commands will start to fail, e.g. "modprobe vt". Since v=
t
          can't be compiled as a module it's not present in modules.builtin
          index. Previously we would report at as builtin, but now we fail
          because we couldn't find the module.

- Improvements:
        - Integration of gcov into the build. Currently libkmod is at ~70%
          coverage and tools at ~50% by tests in the testsuite. Utility
          functions and structures in shared have more than 90% of coverage=
.
        - Upload build to coverity

- Improvements to testsuite:
        - Fix parsing return codes of init_module() calls
        - Add tests for utility functions in shared/
        - Add tests for kmod_module_remove_module()
        - Add playground, in which our own modules are compiled
        - Port all tests to use modules from module-playground instead of
          copying prebuilt modules to the repository
        - Properly handle binaries that exit with no output
        - Besides comparing the output of commands, allow to copy to
          stdout/stderr

Shortlog:

Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com> (6):
      tools: kmod: break iteration once a command is executed
      testsuite: add test for hash_add_unique
      testsuite: add test for growing then shrinking a hash
      testsuite: add more input cases to freadline_wrapped test
      util: remove dead code in freadline_wrapped
      testsuite: add tests for kmod_list

Colin Walters <walters@verbum.org> (1):
      depmod: Fix crash in previous commit if root is not set

David Herrmann <dh.herrmann@gmail.com> (2):
      from systemd: build: check for build/link flags harder
      from systemd: build: make sure to test for -Wflag instead of -Wno-fla=
g

Harish Jenny K N <harish_kandiga@mentor.com> (1):
      Fix race while loading modules

Lucas De Marchi <lucas.demarchi@intel.com> (78):
      NEWS: Fix typos
      README: move mailing list information to top
      build-sys: Don't add libkmod subdirectory to include path
      build-sys: Don't define LIBEXECDIR
      build-sys: set -e separately, rather than putting -e in the shebang l=
ine
      Remove FSF mailing address
      Fix includes after change to build-sys
      libkmod-elf: Remove unused variables
      Fix include in python bindings
      build-sys: rename cflags/ldflags variable
      testsuite: do not overrid paths inside build
      build-sys: integrate coverage report
      testsuite: add test for array_pop()
      Update TODO
      CODING-STYLE: add include order
      tools: kmod: use streq
      testsuite: fix retcodes parsing
      shared: add STRINGFY macro
      testsuite: test kmod_module_remove_module for failure
      testsuite: prefer the use of streq()
      tools: prefer the use of streq()
      testsuite: improve assert report
      testsuite: improve coverage of shared/util.h
      build: enable LTO and _FORTIFY_SOURCE with optimization
      build: pass --no-undefined to linker
      Fix uninitialized warning
      Revert "build: enable LTO and _FORTIFY_SOURCE with optimization"
      Update TODO
      testsuite: beef up module-playground in the build system
      testsuite: use mod-simple.ko for search-order-same-prefix test
      testsuite: make test-dependencies use DEFINE_TEST
      testsuite: port test-dependencies to module-playground
      build: let touch on directory as last step
      testsuite: convert test-init function to use mod-simple.ko
      travis: use kernel headers for testsuite
      travis: also test with gcc 4.8 and 4.9
      testsuite: port detect-loop test to module-playground
      build: add better check for builtin function
      build: check for required builtin functions
      testsuite: port show-depends tests to module-playground
      build: define to 0 if builtin is not available
      shared: add helper function to add and check for overflow
      libkmod: use helper function to check for overflow
      testsuite: port softdep-loop test to module-playground
      testsuite: port modprobe --force test to module-playground
      testsuite: port tests without finit_module() to module-playground
      testsuite: port alias-to-none test to module-playground
      testsuite: port install-cmd-loop test to module-playground
      testsuite: port kcmdline test to module-playground
      libkmod: consider empty signature key as invalid
      libkmod: better explain a signed module layout
      Update TODO
      testsuite: port modules-order-compressed to module-playground
      module-playground: allow to cross-compile modules
      testsuite: fix exiting with success on no output activity
      testsuite: add option to copy output from test
      testsuite: leave arch-specific modules in tree
      fixup! module-playground: allow to cross-compile modules
      testsuite: port arch-specific tests to module-playground
      testsuite: port signature-check modules to module-playground
      module-playground: don clean all .ko files
      build: add missing files to EXTRA_DIST
      from systemd: build: merge trivial changes back
      depmod: fix leaking root on exit
      depmod: use cleanup attribute to simplify free on exit
      build: add helpers to upload coverity tarball
      depmod: fix leak in case of malloc(0)
      build: simplify and organize configure
      shared: avoid checking for __STDC_VERSION__
      build: we are kmod, not systemd
      testsuite: test builtin state
      modprobe: stop checking initstate for builtin modules
      testsuite: add test for modprobe -R <builtin-module>
      depmod: add asserts to ensure positive return from ftell()
      Avoid sign-extension error on multiplication
      Check return of fseek while reading index
      Update TODO
      kmod 20

Marcus Meissner <meissner@suse.de> (1):
      testsuite: move test-blacklist to DEFINE_TEST

Mike Auty <ikelos@gentoo.org> (1):
      build: Do not force diagnostics-color flag

Natanael Copa <ncopa@alpinelinux.org> (1):
      util: fix build on systems missing strndupa

Tobias Stoeckmann <tobias@stoeckmann.org> (3):
      Prevent offset + size overflow.
      libkmod: properly validate file size
      Fix out of bounds signature access with 32 bit off_t

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> (1):
      from systemd: build-sys: fix conftest.c to work on arm

--=20
Lucas De Marchi
