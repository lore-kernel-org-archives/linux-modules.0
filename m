MIME-Version: 1.0
In-Reply-To: <5255F73C.6050908@linux.intel.com>
References: <1381359227-29867-1-git-send-email-sgw@linux.intel.com>
	<CAKi4VALxoEXMu5DQBZbX9ckGCtSX6-EF7ehnLtLPxF9PumUE+g@mail.gmail.com>
	<5255F73C.6050908@linux.intel.com>
Date: Wed, 9 Oct 2013 21:55:55 -0300
Message-ID: <CAKi4VAKjs==_8-GC09tFeaDZUhSF18UvSdWx4wni7agdAkkfWA@mail.gmail.com>
Subject: Re: [PATCH] Makefile.am: add mkdir testsuite and standaline build target
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Saul Wold <sgw@linux.intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Oct 9, 2013 at 9:39 PM, Saul Wold <sgw@linux.intel.com> wrote:
> On 10/09/2013 04:30 PM, Lucas De Marchi wrote:
>>
>> Hi Saul,
>>
>> On Wed, Oct 9, 2013 at 7:53 PM, Saul Wold <sgw@linux.intel.com> wrote:
>>>
>>> If we are not building in the existing source tree, the testsuite
>>> directory will not exist so the cp of the stamp-rootfs would fail.
>>>
>>> Also added buildtest-TESTS so they could be build in the cross env,
>>> without running the tests.
>>>
>>> Signed-off-by: Saul Wold <sgw@linux.intel.com>
>>> ---
>>>   Makefile.am | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile.am b/Makefile.am
>>> index c165868..018e6ed 100644
>>> --- a/Makefile.am
>>> +++ b/Makefile.am
>>> @@ -131,7 +131,7 @@ endif
>>>
>>>   ROOTFS =3D testsuite/rootfs
>>>   ROOTFS_PRISTINE =3D $(top_srcdir)/testsuite/rootfs-pristine
>>> -CREATE_ROOTFS =3D $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && \
>>> +CREATE_ROOTFS =3D $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir
>>> $(ROOTFS)) && \
>>
>>
>> I think it's something else that's causing a failure for you.  The
>> following works for me:
>>
>> $ ./autogen.sh
>> $ cd /tmp/build
>> $ $OLDPWD/configure --sysconfdir=3D/etc --with-zlib && make -j10 check
>>
>> You really need the --sysconfdir=3D/etc and --with-zlib otherwise some
>> tests will fail.  These are the flags we pass to distcheck, that also
>> builds out of tree (but in an inner directory)
>>
> Since I am not running check on the build machine, I am running check on =
the
> target, I create an installable package that includes the rootfs and test=
s,
> to this I run make rootfs on the build machine, can you veify that that
> works in a clean build directory?

The testsuite directory is being created here during configure, even
before any make or make check. See below:


=E2=94=94 build2 =E2=9E=A4 pwd
/tmp/build2
=E2=94=94 build2 =E2=9E=A4 ls -l
total 0
=E2=94=94 build2 =E2=9E=A4 /home/lucas/p/kmod/configure --prefix=3D/usr
--sysconfdir=3D/etc --libdir=3D/usr/lib --enable-debug --with-xz
--with-zlib
=E2=94=94 build2 =E2=9E=A4 find .
.
./libtool
./tools
./tools/.deps
./tools/.deps/static-nodes.Po
./tools/.deps/rmmod.Po
./tools/.deps/modprobe.Po
./tools/.deps/modinfo.Po
./tools/.deps/lsmod.Po
./tools/.deps/log.Po
./tools/.deps/kmod.Po
./tools/.deps/insmod.Po
./tools/.deps/depmod.Po
./testsuite
./testsuite/.deps
./testsuite/.deps/uname.Plo
./testsuite/.deps/testsuite_test_testsuite-test-testsuite.Po
./testsuite/.deps/testsuite_test_new_module-test-new-module.Po
./testsuite/.deps/testsuite_test_modprobe-test-modprobe.Po
./testsuite/.deps/testsuite_test_modinfo-test-modinfo.Po
./testsuite/.deps/testsuite_test_loaded-test-loaded.Po
./testsuite/.deps/testsuite_test_init-test-init.Po
./testsuite/.deps/testsuite_test_depmod-test-depmod.Po
./testsuite/.deps/testsuite_test_dependencies-test-dependencies.Po
./testsuite/.deps/testsuite_test_blacklist-test-blacklist.Po
./testsuite/.deps/testsuite_test_alias-test-alias.Po
./testsuite/.deps/testsuite_libtestsuite_la-testsuite.Plo
./testsuite/.deps/path.Plo
./testsuite/.deps/init_module.Plo
./testsuite/.deps/delete_module.Plo
./stamp-h1
./config.h
./libkmod
./libkmod/.deps
./libkmod/.deps/libkmod.Plo
./libkmod/.deps/libkmod-util.Plo
./libkmod/.deps/libkmod-signature.Plo
./libkmod/.deps/libkmod-module.Plo
./libkmod/.deps/libkmod-list.Plo
./libkmod/.deps/libkmod-index.Plo
./libkmod/.deps/libkmod-hash.Plo
./libkmod/.deps/libkmod-file.Plo
./libkmod/.deps/libkmod-elf.Plo
./libkmod/.deps/libkmod-config.Plo
./libkmod/.deps/libkmod-array.Plo
./libkmod/docs
./libkmod/docs/version.xml
./libkmod/docs/Makefile
./man
./man/Makefile
./Makefile
./config.status
./config.log


>
> Since the make check above will create the testsuite directory and build =
all
> the tests before rootfs target is called, in my case that does not happen=
.
>
>
>
>>>                                  cp -r $(ROOTFS_PRISTINE) $(ROOTFS) && =
\
>>>                                  touch testsuite/stamp-rootfs && \
>>>                                  find $(ROOTFS) -type d -exec chmod +w =
{}
>>> \; )
>>> @@ -217,6 +217,9 @@ DISTCHECK_CONFIGURE_FLAGS=3D--enable-gtk-doc
>>> --sysconfdir=3D/etc --with-zlib
>>>
>>>   distclean-local: $(DISTCLEAN_LOCAL_HOOKS)
>>>
>>> +buildtest-TESTS:
>>> +       $(MAKE) $(AM_MAKEFLAGS) $(check_LTLIBRARIES) $(check_PROGRAMS)
>>> +
>>
>>
>> Makes sense. Splitting the patch would be good.
>>
>
> Do you still want this split based on the above observation?

Yes, it's better.

thanks
Lucas De Marchi
