Return-Path: <holger@eitzenberger.org>
Date: Tue, 28 Oct 2014 14:53:49 +0100
From: Holger Eitzenberger <holger@eitzenberger.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: jcm@jonmasters.org, linux-modules <linux-modules@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, sebastian.poehn@sophos.com
Subject: Re: [RESEND] Regression using module-init-tools on Kernel v3.12.y
Message-ID: <20141028135349.GA7646@imap.eitzenberger.org>
References: <20141027122742.GD9396@imap.eitzenberger.org>
 <CAKi4VAJPseEvxWG4x-vQp9_=pp44xR2t7F3_LQGJeU2zKmmfkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VAJPseEvxWG4x-vQp9_=pp44xR2t7F3_LQGJeU2zKmmfkA@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>


> > Still, does the attached patch makes sense to apply to git GIT repo?
> > It modifies elfops to support old and new format of the table name.
> 
> I don't think so... even more because I don't agree with "there is
> quite some userbase of module-init-tools out there" particularly
> because all major distros in newer versions changed to kmod (and for
> the majority of them this happened back in 2012).

True if you compare just number of users of libkmod against number
of users of module-init-tools.  However, in absolute terms
this may still be huge number not using libkmod already.

The main intention was to have this applied in order to avoid work for
others -- and to get rich and famous.

> So... you could either convince Jon Masters to apply your patch or
> send the patch to the distro in question.

That was the main intention of the initial email :).  And (2): I *am*
the distro ;).

 /Holger
