MIME-Version: 1.0
In-Reply-To: <54528539.4000600@redhat.com>
References: <20141030160932.15107fde@PAL-U515208D001>
	<54526645.2010008@redhat.com>
	<20141030173744.681f77df@PAL-U515208D001>
	<54528539.4000600@redhat.com>
Date: Sat, 15 Nov 2014 11:34:56 -0200
Message-ID: <CAKi4VAKboFTst4_Th19aVpu0GrYtqbw-t=-1MCzn-ScJCAaGEQ@mail.gmail.com>
Subject: Re: Debugging AttributeError: 'module' object has no attribute 'kmod'
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andy Grover <agrover@redhat.com>
Cc: Christophe Vu-Brugier <cvubrugier@fastmail.fm>, targetcli-fb-devel@lists.fedorahosted.org,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi, sorry for the delay

On Thu, Oct 30, 2014 at 4:36 PM, Andy Grover <agrover@redhat.com> wrote:
> On 10/30/2014 09:37 AM, Christophe Vu-Brugier wrote:
>>
>> Hi Andy,
>>
>> On Thu, 30 Oct 2014 09:24:37 -0700, Andy Grover wrote :
>>>
>>> On 10/30/2014 08:09 AM, Christophe Vu-Brugier wrote:
>>>>
>>>> Hi Andy,
>>>>
>>>> I am working on better integrating targetcli in Buildroot. Buildroot
>>>> is an easy to configure build system that uses cross compilation to
>>>> generate tiny root file systems for embedded platforms.
>>>>
>>>> Buildroot supports systemd so I built a root file system with
>>>> targetcli and systemd. When systemd is selected as the init system in
>>>> Buildroot, the python-kmod module is also built by Buildroot (because
>>>> kmod is a dependency of systemd). And since python-kmod is present,
>>>> targetcli tries to use it. But it fails with the following error:
>>>>
>>>>     # targetcli
>>>>     Traceback (most recent call last):
>>>>       File "/usr/bin/targetcli", line 100, in <module>
>>>>         main()
>>>>       File "/usr/bin/targetcli", line 63, in main
>>>>         root_node = UIRoot(shell, as_root=is_root)
>>>>       File
>>>> "home/cvubrugier/repos/buildroot/output/x86-targetcli-systemd/target/usr/lib/python3.4/site-packages/targetcli/ui_root.py",
>>>> line 44, in __init__
>>>>       File
>>>> "home/cvubrugier/repos/buildroot/output/x86-targetcli-systemd/target/usr/lib/python3.4/site-packages/rtslib/root.py",
>>>> line 66, in __init__
>>>>       File
>>>> "home/cvubrugier/repos/buildroot/output/x86-targetcli-systemd/target/usr/lib/python3.4/site-packages/rtslib/utils.py",
>>>> line 364, in modprobe
>>>>     AttributeError: 'module' object has no attribute 'Kmod'
>>>>
>>>> Trying to use python-kmod by hand also fails on the system.
>>>>
>>>>     Python 3.4.1 (default, Oct 29 2014, 13:37:35)
>>>>     [GCC 4.9.1] on linux
>>>>     Type "help", "copyright", "credits" or "license" for more
>>>> information.
>>>>     >>> import kmod
>>>>     >>> km = kmod.kmod()

it should be kmod.Kmod()

Note the capital K.

> (CCing kmod dev list too)
>
> Starting in kmod v17 the Python library was merged into the main kmod repo,
> and the version indicates that you are using the Python wrapper built from
> that (as opposed to the now-defunct separate project called python-kmod,
> whose versions never exceeded 0.9.)
>
> Lucas De Marchi did the build integration because my autotools knowledge was
> not sufficient -- I suspect building kmod with --enable-python only enables
> Python 2. I'd need to know more about what distro you're on and look at the
> packaging scripts, but I think upstream support for building the library for
> Python 3 is needed (this might be extremely simple but it still probably
> requires a separate --enable-python3 configure option). Did the packager
> think they could just take the Py2 binaries and they'd work for Python 3???
>
> So I'd open an issue with the kmod packager for whatever distro because
> something is broken, and maybe the CC'd upstream developers might also be
> able to help us have explicit support for building for Python 3?

It should work fine with python3 as well. Just tested here:

$ make install DESTDIR=/tmp/inst
$ PYTHONPATH=/tmp/inst/usr/lib/python3.4/site-packages python3
Python 3.4.2 (default, Oct  8 2014, 13:44:52)
[GCC 4.9.1 20140903 (prerelease)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import kmod
>>> km = kmod.Kmod()
>>> km.loaded()
<generator object at 0x7fbf9f807cc8>

-- 
Lucas De Marchi
