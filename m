MIME-Version: 1.0
In-Reply-To: <5255FF8C.7080006@linux.intel.com>
References: <1381359227-29867-1-git-send-email-sgw@linux.intel.com>
	<CAKi4VALxoEXMu5DQBZbX9ckGCtSX6-EF7ehnLtLPxF9PumUE+g@mail.gmail.com>
	<5255F73C.6050908@linux.intel.com>
	<CAKi4VAKjs==_8-GC09tFeaDZUhSF18UvSdWx4wni7agdAkkfWA@mail.gmail.com>
	<5255FF8C.7080006@linux.intel.com>
Date: Thu, 10 Oct 2013 01:15:49 -0300
Message-ID: <CAKi4VA+Bo0HG6YC9F3NhGHxPpY1LNODOJYf2x4usftg4_3aMyw@mail.gmail.com>
Subject: Re: [PATCH] Makefile.am: add mkdir testsuite and standaline build target
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Saul Wold <sgw@linux.intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Oct 9, 2013 at 10:14 PM, Saul Wold <sgw@linux.intel.com> wrote:
> On 10/09/2013 05:55 PM, Lucas De Marchi wrote:
>>
>> On Wed, Oct 9, 2013 at 9:39 PM, Saul Wold <sgw@linux.intel.com> wrote:
>>>
>>> On 10/09/2013 04:30 PM, Lucas De Marchi wrote:
>>>>
>>>>
>>>> Hi Saul,
>>>>
>>>> On Wed, Oct 9, 2013 at 7:53 PM, Saul Wold <sgw@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>> If we are not building in the existing source tree, the testsuite
>>>>> directory will not exist so the cp of the stamp-rootfs would fail.
>>>>>
>>>>> Also added buildtest-TESTS so they could be build in the cross env,
>>>>> without running the tests.
>>>>>
>>>>> Signed-off-by: Saul Wold <sgw@linux.intel.com>
>>>>> ---
>>>>>    Makefile.am | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Makefile.am b/Makefile.am
>>>>> index c165868..018e6ed 100644
>>>>> --- a/Makefile.am
>>>>> +++ b/Makefile.am
>>>>> @@ -131,7 +131,7 @@ endif
>>>>>
>>>>>    ROOTFS = testsuite/rootfs
>>>>>    ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
>>>>> -CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && \
>>>>> +CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir
>>>>> $(ROOTFS)) && \
>>>>
>>>>
>>>>
>>>> I think it's something else that's causing a failure for you.  The
>>>> following works for me:
>>>>
>>>> $ ./autogen.sh
>>>> $ cd /tmp/build
>>>> $ $OLDPWD/configure --sysconfdir=/etc --with-zlib && make -j10 check
>>>>
>>>> You really need the --sysconfdir=/etc and --with-zlib otherwise some
>>>> tests will fail.  These are the flags we pass to distcheck, that also
>>>> builds out of tree (but in an inner directory)
>>>>
>>> Since I am not running check on the build machine, I am running check on
>>> the
>>> target, I create an installable package that includes the rootfs and
>>> tests,
>>> to this I run make rootfs on the build machine, can you veify that that
>>> works in a clean build directory?
>>
>>
>> The testsuite directory is being created here during configure, even
>> before any make or make check. See below:
>>
> Not in all cases, it depends on the way configure is called.  I am working
> with bitbake and oe-core, and we call configure with
> --disable-dependency-tracking by default. That's what generates the .deps
> and .Po files and creates the directories.
>
> In my case after a configure toplevel build is:
>
> ~/yocto/builds/world/tmp/work/x86_64-poky-linux/kmod/14+gitAUTOINC+3b38c7
> fcb5-r0/git$ ls ../build/
>
> Makefile      config.h    config.status  man       x86_64-poky-linux-libtool
> aclocal-copy  config.log  libkmod        stamp-h1
>
> Notice no tools, testsuite or libkmod yet.

Ok. Now it makes more sense.  Let's write this down into the commit
message then.

Also notice we don't use signed-off-by


Thanks
Lucas De Marchi
