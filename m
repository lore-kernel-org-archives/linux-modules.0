Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Sep 2012 04:34:32 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
cc: linux-modules <linux-modules@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hotplug <linux-hotplug@vger.kernel.org>
Subject: Re: [ANNOUNCE] kmod 10
In-Reply-To: <CAMOw1v6MYW6O2f4AR9yRvh200j5R6mFTRqDT3TFbG-TjknmUmw@mail.gmail.com>
Message-ID: <alpine.LNX.2.01.1209170427220.6182@nerf07.vanv.qr>
References: <CAMOw1v6MYW6O2f4AR9yRvh200j5R6mFTRqDT3TFbG-TjknmUmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


On Thursday 2012-09-06 21:37, Lucas De Marchi wrote:
>
>kmod 10 is out:
>
>ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-10.tar.xz
>ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-10.tar.sign

make check fails here with glibc-2.15, gcc-4.7, x86_64,
due to what seems to be duplicated symbols(?):


+ make check V=1
Making check in .
make --no-print-directory testsuite/uname.la testsuite/path.la testsuite/init_module.la testsuite/delete_module.la testsuite/libtestsuite.la testsuite/test-init testsuite/test-testsuite testsuite/test-loaded testsuite/test-modinfo testsuite/test-alias testsuite/test-new-module testsuite/test-modprobe testsuite/test-blacklist testsuite/test-dependencies
depbase=`echo testsuite/uname.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -std=gnu99 -std=gnu99 -DHAVE_CONFIG_H -I.  -include ./config.h -I./libkmod -DROOTPREFIX=\"""\" -DSYSCONFDIR=\""/etc"\" -DLIBEXECDIR=\""/usr/lib"\" -I/usr/local/include    -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla -Wundef -Wformat=2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wstrict-aliasing=2 -Wwrite-strings -Wno-long-long -Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-initializers -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-limits -Wuninitialized -fno-common -fdiagnostics-show-option -fvisibility=hidden -ffunction-sections -fdata-sections -fomit-frame-pointer -fmessage-length=0 -O2 -Wall -D_FORTIFY_SOURCE=2 -
 fstack-protector -funwind-tables -fasynchronous-unwind-tables -g -MT testsuite/uname.lo -MD -MP -MF $depbase.Tpo -c -o testsuite/uname.lo testsuite/uname.c &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  gcc -std=gnu99 -std=gnu99 -DHAVE_CONFIG_H -I. -include ./config.h -I./libkmod -DROOTPREFIX=\"\" -DSYSCONFDIR=\"/etc\" -DLIBEXECDIR=\"/usr/lib\" -I/usr/local/include -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla -Wundef -Wformat=2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wstrict-aliasing=2 -Wwrite-strings -Wno-long-long -Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-initializers -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-limits -Wuninitialized -fno-common -fdiagnostics-show-option -fvisibility=hidden -ffunction-sections -fdata-sections -fomit-frame-pointer -fmessage-length=0 -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables -fa
 synchronous-unwind-tables -g -MT testsuite/uname.lo -MD -MP -MF testsuite/.deps/uname.Tpo -c testsuite/uname.c  -fPIC -DPIC -o testsuite/.libs/uname.o
cc1: warning: /usr/local/include: No such file or directory [enabled by default]
/bin/sh ./libtool  --tag=CC   --mode=link gcc -std=gnu99 -std=gnu99 -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla -Wundef -Wformat=2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wstrict-aliasing=2 -Wwrite-strings -Wno-long-long -Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-initializers -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-limits -Wuninitialized -fno-common -fdiagnostics-show-option -fvisibility=hidden -ffunction-sections -fdata-sections -fomit-frame-pointer -fmessage-length=0 -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables -fasynchronous-unwind-tables -g avoid-version -module -shared -export-dynamic -rpath /nowhere -ldl  -o testsuite/uname.
 la  testsuite/uname.lo  
libtool: link: gcc -std=gnu99 -shared  -fPIC -DPIC  testsuite/.libs/uname.o   -ldl  -O2   -Wl,-soname -Wl,uname.so.0 -o testsuite/.libs/uname.so.0.0.0
libtool: link: (cd "testsuite/.libs" && rm -f "uname.so.0" && ln -s "uname.so.0.0.0" "uname.so.0")
libtool: link: (cd "testsuite/.libs" && rm -f "uname.so" && ln -s "uname.so.0.0.0" "uname.so")
libtool: link: ( cd "testsuite/.libs" && rm -f "uname.la" && ln -s "../uname.la" "uname.la" )
depbase=`echo testsuite/path.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -std=gnu99 -std=gnu99 -DHAVE_CONFIG_H -I.  -include ./config.h -I./libkmod -DROOTPREFIX=\"""\" -DSYSCONFDIR=\""/etc"\" -DLIBEXECDIR=\""/usr/lib"\" -I/usr/local/include    -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla -Wundef -Wformat=2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wstrict-aliasing=2 -Wwrite-strings -Wno-long-long -Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-initializers -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-limits -Wuninitialized -fno-common -fdiagnostics-show-option -fvisibility=hidden -ffunction-sections -fdata-sections -fomit-frame-pointer -fmessage-length=0 -O2 -Wall -D_FORTIFY_SOURCE=2 -
 fstack-protector -funwind-tables -fasynchronous-unwind-tables -g -MT testsuite/path.lo -MD -MP -MF $depbase.Tpo -c -o testsuite/path.lo testsuite/path.c &&\
mv -f $depbase.Tpo $depbase.Plo
libtool: compile:  gcc -std=gnu99 -std=gnu99 -DHAVE_CONFIG_H -I. -include ./config.h -I./libkmod -DROOTPREFIX=\"\" -DSYSCONFDIR=\"/etc\" -DLIBEXECDIR=\"/usr/lib\" -I/usr/local/include -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla -Wundef -Wformat=2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wstrict-aliasing=2 -Wwrite-strings -Wno-long-long -Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-initializers -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-limits -Wuninitialized -fno-common -fdiagnostics-show-option -fvisibility=hidden -ffunction-sections -fdata-sections -fomit-frame-pointer -fmessage-length=0 -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables -fa
 synchronous-unwind-tables -g -MT testsuite/path.lo -MD -MP -MF testsuite/.deps/path.Tpo -c testsuite/path.c  -fPIC -DPIC -o testsuite/.libs/path.o
cc1: warning: /usr/local/include: No such file or directory [enabled by default]
{standard input}: Assembler messages:
{standard input}:418: Error: symbol `open64' is already defined
{standard input}:678: Error: symbol `stat64' is already defined
{standard input}:758: Error: symbol `lstat64' is already defined
{standard input}:1234: Error: symbol `__xstat64' is already defined
{standard input}:1396: Error: symbol `__lxstat64' is already defined
make[2]: *** [testsuite/path.lo] Error 1
make[1]: *** [check-am] Error 2
make: *** [check-recursive] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.Eq2Axz (%check)

