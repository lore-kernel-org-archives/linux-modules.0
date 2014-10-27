MIME-Version: 1.0
In-Reply-To: <20141027122742.GD9396@imap.eitzenberger.org>
References: <20141027122742.GD9396@imap.eitzenberger.org>
Date: Mon, 27 Oct 2014 12:51:52 -0200
Message-ID: <CAKi4VAJPseEvxWG4x-vQp9_=pp44xR2t7F3_LQGJeU2zKmmfkA@mail.gmail.com>
Subject: Re: [RESEND] Regression using module-init-tools on Kernel v3.12.y
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: jcm@jonmasters.org, linux-modules <linux-modules@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, sebastian.poehn@sophos.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Oct 27, 2014 at 10:27 AM, Holger Eitzenberger
<holger@eitzenberger.org> wrote:
> Hi all,
>
> we are still using module-init-tools for module handling.  And so does
> SuSE SLES11.
>
> However, after upgrading from kernel v3.8.y to v3.12.y we noticed
> that modules.pcimap was empty, which is due to the fact that the
> DEFINE_PCI_DEVICE_TABLE() has been modified to encode the name of
> the device table.  Which in turn has been done to avoid issues with
> multiple tables in a driver (see [1]).
>
> I understand why this patch went it, and fixing this issue in the PNP
> driver is worth fixing, I agree.
>
> However, there is quite some userbase of module-init-tools out there,
> eventually upgrading as well.  And as a consequence I think it makes
> sense to patch module-init-tools as well to support both format.
>
> I know that module-init-tools are deprecated by libkmod, and therefore
> they seem to be unmaintained since 2011 (at least when looking at
> git.kernel.org).

As you noticed, module-init-tools is not being maintained anymore. I
don't even have access to its repository.

> Still, does the attached patch makes sense to apply to git GIT repo?
> It modifies elfops to support old and new format of the table name.

I don't think so... even more because I don't agree with "there is
quite some userbase of module-init-tools out there" particularly
because all major distros in newer versions changed to kmod (and for
the majority of them this happened back in 2012).

So... you could either convince Jon Masters to apply your patch or
send the patch to the distro in question.

-- 
Lucas De Marchi
