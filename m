MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.01.1209170427220.6182@nerf07.vanv.qr>
References: <CAMOw1v6MYW6O2f4AR9yRvh200j5R6mFTRqDT3TFbG-TjknmUmw@mail.gmail.com>
	<alpine.LNX.2.01.1209170427220.6182@nerf07.vanv.qr>
Date: Mon, 8 Oct 2012 10:38:53 -0300
Message-ID: <CAKi4VAKj0C7-Ug4M=s7wSFGZeP5Tr0Tt1vyg41tKhf01mA+vcQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] kmod 10
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-modules <linux-modules@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-hotplug <linux-hotplug@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, Sep 16, 2012 at 11:34 PM, Jan Engelhardt <jengelh@inai.de> wrote:
>
> On Thursday 2012-09-06 21:37, Lucas De Marchi wrote:
>>
>>kmod 10 is out:
>>
>>ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-10.tar.xz
>>ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-10.tar.sign
>
> make check fails here with glibc-2.15, gcc-4.7, x86_64,
> due to what seems to be duplicated symbols(?):
>
>
> + make check V=3D1
> Making check in .
> make --no-print-directory testsuite/uname.la testsuite/path.la testsuite/=
init_module.la testsuite/delete_module.la testsuite/libtestsuite.la testsui=
te/test-init testsuite/test-testsuite testsuite/test-loaded testsuite/test-=
modinfo testsuite/test-alias testsuite/test-new-module testsuite/test-modpr=
obe testsuite/test-blacklist testsuite/test-dependencies
> depbase=3D`echo testsuite/uname.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
> /bin/sh ./libtool  --tag=3DCC   --mode=3Dcompile gcc -std=3Dgnu99 -std=3D=
gnu99 -DHAVE_CONFIG_H -I.  -include ./config.h -I./libkmod -DROOTPREFIX=3D\=
"""\" -DSYSCONFDIR=3D\""/etc"\" -DLIBEXECDIR=3D\""/usr/lib"\" -I/usr/local/=
include    -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla =
-Wundef -Wformat=3D2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissin=
g-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -=
Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes=
 -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-nor=
eturn -Wshadow -Wendif-labels -Wstrict-aliasing=3D2 -Wwrite-strings -Wno-lo=
ng-long -Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-in=
itializers -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-lim=
its -Wuninitialized -fno-common -fdiagnostics-show-option -fvisibility=3Dhi=
dden -ffunction-sections -fdata-sections -fomit-frame-pointer -fmessage-len=
gth=3D0 -O2 -Wall -D_FORTIFY_SOURCE=3D2 -
>  fstack-protector -funwind-tables -fasynchronous-unwind-tables -g -MT tes=
tsuite/uname.lo -MD -MP -MF $depbase.Tpo -c -o testsuite/uname.lo testsuite=
/uname.c &&\
> mv -f $depbase.Tpo $depbase.Plo
> libtool: compile:  gcc -std=3Dgnu99 -std=3Dgnu99 -DHAVE_CONFIG_H -I. -inc=
lude ./config.h -I./libkmod -DROOTPREFIX=3D\"\" -DSYSCONFDIR=3D\"/etc\" -DL=
IBEXECDIR=3D\"/usr/lib\" -I/usr/local/include -pipe -DANOTHER_BRICK_IN_THE =
-Wall -W -Wextra -Wno-inline -Wvla -Wundef -Wformat=3D2 -Wlogical-op -Wsign=
-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold=
-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement=
 -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -=
Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wstrict-a=
liasing=3D2 -Wwrite-strings -Wno-long-long -Wno-overlength-strings -Wno-unu=
sed-parameter -Wno-missing-field-initializers -Wno-unused-result -Wnested-e=
xterns -Wchar-subscripts -Wtype-limits -Wuninitialized -fno-common -fdiagno=
stics-show-option -fvisibility=3Dhidden -ffunction-sections -fdata-sections=
 -fomit-frame-pointer -fmessage-length=3D0 -O2 -Wall -D_FORTIFY_SOURCE=3D2 =
-fstack-protector -funwind-tables -fa
>  synchronous-unwind-tables -g -MT testsuite/uname.lo -MD -MP -MF testsuit=
e/.deps/uname.Tpo -c testsuite/uname.c  -fPIC -DPIC -o testsuite/.libs/unam=
e.o
> cc1: warning: /usr/local/include: No such file or directory [enabled by d=
efault]
> /bin/sh ./libtool  --tag=3DCC   --mode=3Dlink gcc -std=3Dgnu99 -std=3Dgnu=
99 -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla -Wundef =
-Wformat=3D2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-includ=
e-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-se=
lf -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstric=
t-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -W=
shadow -Wendif-labels -Wstrict-aliasing=3D2 -Wwrite-strings -Wno-long-long =
-Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-initialize=
rs -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-limits -Wun=
initialized -fno-common -fdiagnostics-show-option -fvisibility=3Dhidden -ff=
unction-sections -fdata-sections -fomit-frame-pointer -fmessage-length=3D0 =
-O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector -funwind-tables -fasynchr=
onous-unwind-tables -g avoid-version -module -shared -export-dynamic -rpath=
 /nowhere -ldl  -o testsuite/uname.
>  la  testsuite/uname.lo
> libtool: link: gcc -std=3Dgnu99 -shared  -fPIC -DPIC  testsuite/.libs/una=
me.o   -ldl  -O2   -Wl,-soname -Wl,uname.so.0 -o testsuite/.libs/uname.so.0=
.0.0
> libtool: link: (cd "testsuite/.libs" && rm -f "uname.so.0" && ln -s "unam=
e.so.0.0.0" "uname.so.0")
> libtool: link: (cd "testsuite/.libs" && rm -f "uname.so" && ln -s "uname.=
so.0.0.0" "uname.so")
> libtool: link: ( cd "testsuite/.libs" && rm -f "uname.la" && ln -s "../un=
ame.la" "uname.la" )
> depbase=3D`echo testsuite/path.lo | sed 's|[^/]*$|.deps/&|;s|\.lo$||'`;\
> /bin/sh ./libtool  --tag=3DCC   --mode=3Dcompile gcc -std=3Dgnu99 -std=3D=
gnu99 -DHAVE_CONFIG_H -I.  -include ./config.h -I./libkmod -DROOTPREFIX=3D\=
"""\" -DSYSCONFDIR=3D\""/etc"\" -DLIBEXECDIR=3D\""/usr/lib"\" -I/usr/local/=
include    -pipe -DANOTHER_BRICK_IN_THE -Wall -W -Wextra -Wno-inline -Wvla =
-Wundef -Wformat=3D2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissin=
g-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -=
Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes=
 -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-nor=
eturn -Wshadow -Wendif-labels -Wstrict-aliasing=3D2 -Wwrite-strings -Wno-lo=
ng-long -Wno-overlength-strings -Wno-unused-parameter -Wno-missing-field-in=
itializers -Wno-unused-result -Wnested-externs -Wchar-subscripts -Wtype-lim=
its -Wuninitialized -fno-common -fdiagnostics-show-option -fvisibility=3Dhi=
dden -ffunction-sections -fdata-sections -fomit-frame-pointer -fmessage-len=
gth=3D0 -O2 -Wall -D_FORTIFY_SOURCE=3D2 -
>  fstack-protector -funwind-tables -fasynchronous-unwind-tables -g -MT tes=
tsuite/path.lo -MD -MP -MF $depbase.Tpo -c -o testsuite/path.lo testsuite/p=
ath.c &&\
> mv -f $depbase.Tpo $depbase.Plo
> libtool: compile:  gcc -std=3Dgnu99 -std=3Dgnu99 -DHAVE_CONFIG_H -I. -inc=
lude ./config.h -I./libkmod -DROOTPREFIX=3D\"\" -DSYSCONFDIR=3D\"/etc\" -DL=
IBEXECDIR=3D\"/usr/lib\" -I/usr/local/include -pipe -DANOTHER_BRICK_IN_THE =
-Wall -W -Wextra -Wno-inline -Wvla -Wundef -Wformat=3D2 -Wlogical-op -Wsign=
-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold=
-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement=
 -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -=
Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wstrict-a=
liasing=3D2 -Wwrite-strings -Wno-long-long -Wno-overlength-strings -Wno-unu=
sed-parameter -Wno-missing-field-initializers -Wno-unused-result -Wnested-e=
xterns -Wchar-subscripts -Wtype-limits -Wuninitialized -fno-common -fdiagno=
stics-show-option -fvisibility=3Dhidden -ffunction-sections -fdata-sections=
 -fomit-frame-pointer -fmessage-length=3D0 -O2 -Wall -D_FORTIFY_SOURCE=3D2 =
-fstack-protector -funwind-tables -fa
>  synchronous-unwind-tables -g -MT testsuite/path.lo -MD -MP -MF testsuite=
/.deps/path.Tpo -c testsuite/path.c  -fPIC -DPIC -o testsuite/.libs/path.o
> cc1: warning: /usr/local/include: No such file or directory [enabled by d=
efault]
> {standard input}: Assembler messages:
> {standard input}:418: Error: symbol `open64' is already defined
> {standard input}:678: Error: symbol `stat64' is already defined
> {standard input}:758: Error: symbol `lstat64' is already defined
> {standard input}:1234: Error: symbol `__xstat64' is already defined
> {standard input}:1396: Error: symbol `__lxstat64' is already defined
> make[2]: *** [testsuite/path.lo] Error 1
> make[1]: *** [check-am] Error 2
> make: *** [check-recursive] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.Eq2Axz (%check)

For completeness of ML archives: it's fixed on git:
http://git.kernel.org/?p=3Dutils/kernel/kmod/kmod.git;a=3Dcommit;h=3Dd64234=
17778d049b07a3091c3972160be99c9173


Lucas De Marchi
