Return-Path: <cvubrugier@fastmail.fm>
Date: Sat, 15 Nov 2014 21:59:49 +0100
From: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Andy Grover <agrover@redhat.com>,
 targetcli-fb-devel@lists.fedorahosted.org, linux-modules
 <linux-modules@vger.kernel.org>
Subject: Re: Debugging AttributeError: 'module' object has no attribute
 'kmod'
Message-ID: <20141115215949.13633c93@trantor>
In-Reply-To: <CAKi4VAKboFTst4_Th19aVpu0GrYtqbw-t=-1MCzn-ScJCAaGEQ@mail.gmail.com>
References: <20141030160932.15107fde@PAL-U515208D001>
	<54526645.2010008@redhat.com>
	<20141030173744.681f77df@PAL-U515208D001>
	<54528539.4000600@redhat.com>
	<CAKi4VAKboFTst4_Th19aVpu0GrYtqbw-t=-1MCzn-ScJCAaGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Sat, 15 Nov 2014 11:34:56 -0200, Lucas De Marchi wrote :
> >>>> Trying to use python-kmod by hand also fails on the system.
> >>>>
> >>>>     Python 3.4.1 (default, Oct 29 2014, 13:37:35)
> >>>>     [GCC 4.9.1] on linux
> >>>>     Type "help", "copyright", "credits" or "license" for more
> >>>> information.
> >>>>     >>> import kmod
> >>>>     >>> km = kmod.kmod()
> 
> it should be kmod.Kmod()
> 
> Note the capital K.

Yes.

I tested kmod with Python 3 outside of Buildroot and it works fine.

However, with Buildroot there is a problem because Buildroot generates a
Python 3 installation that does not follow PEP 3147 "PYC Repository
Directories". This means that *.py[co] files are not installed in
__pycache__ directories and this makes python-kmod fail. But this is
problem with Buildroot's Python 3 installation. There is no issue with
Kmod here.

Thanks!

> > (CCing kmod dev list too)
> >
> > Starting in kmod v17 the Python library was merged into the main
> > kmod repo, and the version indicates that you are using the Python
> > wrapper built from that (as opposed to the now-defunct separate
> > project called python-kmod, whose versions never exceeded 0.9.)
> >
> > Lucas De Marchi did the build integration because my autotools
> > knowledge was not sufficient -- I suspect building kmod with
> > --enable-python only enables Python 2. I'd need to know more about
> > what distro you're on and look at the packaging scripts, but I
> > think upstream support for building the library for Python 3 is
> > needed (this might be extremely simple but it still probably
> > requires a separate --enable-python3 configure option). Did the
> > packager think they could just take the Py2 binaries and they'd
> > work for Python 3???
> >
> > So I'd open an issue with the kmod packager for whatever distro
> > because something is broken, and maybe the CC'd upstream developers
> > might also be able to help us have explicit support for building
> > for Python 3?
> 
> It should work fine with python3 as well. Just tested here:
> 
> $ make install DESTDIR=/tmp/inst
> $ PYTHONPATH=/tmp/inst/usr/lib/python3.4/site-packages python3
> Python 3.4.2 (default, Oct  8 2014, 13:44:52)
> [GCC 4.9.1 20140903 (prerelease)] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import kmod
> >>> km = kmod.Kmod()
> >>> km.loaded()
> <generator object at 0x7fbf9f807cc8>
> 


-- 
Christophe Vu-Brugier
