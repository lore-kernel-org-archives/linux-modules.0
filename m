MIME-Version: 1.0
In-Reply-To: <54EC638E.1060007@mentor.com>
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
	<54EB4C83.2000500@suse.cz>
	<54EC638E.1060007@mentor.com>
Date: Tue, 24 Feb 2015 22:07:22 -0300
Message-ID: <CAKi4VAKL4B3cLZN5afyeTMaZ49z2eRXcnBRtNi+0so0G8m5dYQ@mail.gmail.com>
Subject: Re: Differences between builtins and modules
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Harish Jenny Kandiga Nagaraj <harish_kandiga@mentor.com>
Cc: Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 24, 2015 at 8:42 AM, Harish Jenny Kandiga Nagaraj
<harish_kandiga@mentor.com> wrote:
>
> On Monday 23 February 2015 09:21 PM, Michal Marek wrote:
>> On 2015-02-23 15:30, Lucas De Marchi wrote:
> Can we add some flag like
> KMOD_PROBE_FORCE_DIRECTORY_CHECK =3D 0x00040,
> and pass it to kmod_module_get_initstate to make
> "modprobe --show-depends vt" to report as "builtin" ?

I don't want to add more flags. It's already pretty complicated, more
than it should IMO. If the tools using kmod can live with the change
proposed here, I'm ok with that.

> Also if the use case for loading builtin modules is not that common
> ( Also don=E2=80=99t know if 'modprobe vt' command does the loading if no=
t loaded)
> can we have the same flags be used after checking if it is  .ko file or f=
rom .o file if required?

Well... there's no way for us to arrive at the final call to
finit_module() for a builtin module. Simply because there's no file to
load in memory (or fd to open) to pass to these functions. We simply
fail because we can't reach that far in the code.

--=20
Lucas De Marchi
