MIME-Version: 1.0
In-Reply-To: <1394125426-31945-1-git-send-email-mmarek@suse.cz>
References: <1394125426-31945-1-git-send-email-mmarek@suse.cz>
Date: Thu, 6 Mar 2014 23:11:57 -0300
Message-ID: <CAKi4VAJrsiSa4BhN2bYL-W3wEYh5GtqsvD6hq_b=eO9pP+X9rg@mail.gmail.com>
Subject: Re: [PATCH] testsuite: Fix uname() during glibc startup
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Thu, Mar 6, 2014 at 2:03 PM, Michal Marek <mmarek@suse.cz> wrote:
> In a specific configuration (chroot with the linux32 personality), the
> modprobe_install_cmd_loop test failed, because the bash process handling
> the install command segfaulted. The backtrace showed a uname() call
> during libpthread initialization, at which point the environ pointer
> hadn't been initialized yet:
>
>         Program terminated with signal SIGSEGV, Segmentation fault.
>         #0  0x080c1591 in getenv (name=<optimized out>,
>             name@entry=0xf775f850 "TESTSUITE_UNAME_R") at getenv.c:81
>         81            for (i = 0, len = strlen (name); environ[i]; i++)
>         (gdb) bt
>         #0  0x080c1591 in getenv (name=<optimized out>,
>             name@entry=0xf775f850 "TESTSUITE_UNAME_R") at getenv.c:81
>         #1  0xf775f754 in uname (u=u@entry=0xff946350) at testsuite/uname.c:32
>         #2  0xf74ffc6c in is_smp_system ()
>             at ../nptl/sysdeps/unix/sysv/linux/i386/smp.h:39
>         #3  __pthread_initialize_minimal_internal () at nptl-init.c:460
>         #4  0xf74fe32c in _init () at ../sysdeps/i386/crti.S:74
>         #5  0x00000000 in ?? ()
>         (gdb) p environ
>         $1 = (char **) 0x0
>
> I don't know why it only happend in the chroot, but glibc can call its
> own functions and impose any restrictions before main() is started, so
> we have to adapt.
>
> Also, do not return error if there is an environment, but the
> environment variable is not found. If uname() is called by kmod, then
> the respective test will simply fail later. If it's something else
> calling uname(), then we do not want to disturb the program.
> ---
>  testsuite/uname.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Applied. Thanks

--
Lucas De Marchi
