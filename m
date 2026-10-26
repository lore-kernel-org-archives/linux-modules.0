Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054777;
	b=E5/+o/LyVUDCllbVkJGLa86sj2ONCIn85pEmzbF6+hGs/kJ4UuGyPN9PKNoQmXNgvHaz
	 lw10jO0lJY5Kej/YpsfKpwVMT3RBPC0/5mcJscAXLPbiyMwaHSKmdtIRx+N3Qdaj8psNq
	 uaJijvfLMqGXs8m8AKGxG+JYLhHQYBgEiCuBTt/S/nBHX180Tw6Fz+L7DWewndayZgoc4
	 X8mmHsc3Pa9Arv0LKmPlXVasXqqdpHAUanH2lZkVCi/KzcB+c17B2d5UQApxx+UOGcD2c
	 hxpBJyXQ0497gPGR/LdbcyERsY7y5wM5XCdVlBGaUuZVN0H5ku3oFu9jNsHcQF7UNjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
	b=UimC1bvAhyplwBjVvxcGNpdBgzGNODVUA+plmo9gYtrNaUOq2XvBaLkwpnRFDr8cwTX2
	 7mic7drxpugXh/yYlKXGOUKyYWlej2QPf6pvZC0SdT3rfZoD2Vk2AWeganIcYYTwpxUZb
	 pagZPWZRSXLue09fADmWu0NdmcP0YnFoiseeOiU3jaS+1CqSFvFAZkm3sx/8qBfZwtH0z
	 tv+tkqTiAJBx4dXPxM6ptVYNMxwisS7m1knNmPf6K2q2s7VNNKLcjVvyZeYp05rD6YhYd
	 jM1FMzdizhkqKUMOXE92ksVaxMWHv+bCx4KWXjQFzPDYLSIV3eG7gciW0L6Ho9SgpMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FkMZwh2x;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544D606A31E
	for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 22:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4544D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FkMZwh2x
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e503815adso381119985a.1
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793054775; x=1793659575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
        b=FkMZwh2xzPGwRXd/6L6YakG28E0XxcbpH4yKhlkVxLiFKRDjnkg0rF4SuQFtOzIsX3
         f5EydNInmzCSCkyh6zkwX5LrW6pJx+yykjP8eF8zTTd4GpSQj2j9YnRNaZqf70z8RmUZ
         V0j9HOG4zRyyPYbjGh8fDJ0CD1b0yexVSSPmIWU3JWr5lLooPlsfB7nv06CCSg5v12eV
         SoxqEP3dz0sh5FDLSqHEK/sK60fYdYH1JO0HlXuGIhkW+uO84PFYtLiQpk8JsiURcZjY
         uPsNy3n6D4nHtcEj11lG1ob2im6ANFeMkqY+1XCA/fQxPdUxjOQ6lMGPBUzC0mYbVssK
         Q32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054775; x=1793659575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
        b=BRkZWGSUnZYeNKWKyDGPjCi5ykOTSce1Qm7M7g84fcffKS/AfocKFecvVG9Nm72FDm
         zaNeEH/daSZ0SsYQd4KhjTOU3M+tJe/VfvgVKxF0R0Ls91uVVWAeD4adHYSordo6A9Lx
         ESkXuZYWZPGI1vgpWrVl6utv6JpwAhCdjRqHbFwVrWuU9Ayo/JbHELSlVAfTZOdsEy1u
         xiSGXc27nf6JjZQ0H8itK+vhXYy6i8aGvpBfr+HlZh2BhTTkghHzsK7uxivA6eecU3fX
         4PH12wu1EoxsoP2zOO1HFt7412Mw7gvtLXSD21JPYvIf35lHBW1BuGFzGGW25uHRW1Nu
         SyMA==
X-Forwarded-Encrypted: i=1; AKwUvBx6R+xjfblCr2xmkaHH9Y5jdFRxhuCc+NfrHHvgG7gLUzIN8/H2EWQNT4CCSjzS0r2PPEBgNkBSkePdCY+B@vger.kernel.org
X-Gm-Message-State: AFq9FYIMmwjBIkUFMr9+TaA2WXUxdufp5qAkOMgPE12ZnqkeSkLxtObW
	E4SPAa55WOlS/l0bPoWo1CbrKyQWWdI1OqEB4U2+avv1Hyf25a5nCAeSXbPVpqr5Cqw=
X-Gm-Gg: AYBFou3gQFYGf37qDMZLUWdtWH3BH2Ogi1NXEBmlqFTAAPw6MTTf1yRxFjekz5j2Wh/
	k237RcrlJD3yC6yMLBdwoa1LGb6z7cuv71W/R9Ji+GMJ53hkkI++jXAbXF7hkawR6CGLDC6jEJ4
	SDFjNqtEQjI7KrBSDByWNgXSPeEnO+4TyBUU2Qj7ph4ja542PGbAj65CphWHsNUbI7OTGu41JB6
	zYOASC1ZSVBvo60Ll8Z0Kudj49NrZH2CTFbhcv/MntmEwbCVXHuaIdx6H5t8axYwWH4698XL8WG
	+UJxpc0nZRBP5CJS0jB1WAge8ptxbjRyZ2C1vP97HB6IDYENzJv9+GkuOlvg39bNM9doyh/y/4Y
	3m8UA3G33tw9ZVorKedDZTrH2ha/wii922k1RBN7SZX0kgmshvjQauS8Xb3nxuouugHUf+va9VE
	0FP5u3eq815yrVNoCElV7ZlYxAhvopzkPxZ54b/qZ3EtfZ7KkzDq0dutlin8mcc6m/83AjM9ixO
	RYPiQrzT0oWe0ZVjMpvOfp3Wfe1qLPmGEIbmhJMGvNpu40ds+5g8QnkT2MPkYxHO9o5huxZYAey
	qUAgF1iVbHqCYRpmQJRvIRqzNgilPFd72Hy0ug==
X-Received: by 2002:a05:620a:4728:b0:93f:2eaf:64cc with SMTP id af79cd13be357-940ef942794mr1259449285a.44.1793054775098;
        Mon, 26 Oct 2026 15:46:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05b20e0sm810207185a.3.2026.10.26.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:46:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLTSF-000000087nJ-1Z9f;
	Mon, 26 Oct 2026 19:46:11 -0300
Date: Mon, 26 Oct 2026 19:46:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026224611.GB1685504@ziepe.ca>
References: <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
 <20261026184312.GA1685504@ziepe.ca>
 <2026102604-tint-catcall-433e@gregkh>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026102604-tint-catcall-433e@gregkh>

On Mon, Oct 26, 2026 at 09:05:06PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 26, 2026 at 03:43:12PM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:
> > 
> > > This is needed for two reasons: to save hardware and software resources
> > > when creating a large number of VFs, and to allow the PCI config space to
> > > be configured *before* the driver starts using it.
> > > 
> > > There is no in-kernel alternative.
> > 
> > Having userspace involved in driver binding has also always been the
> > plan for confidential computing needs. We cannot have a device driver
> > bound across some of the HW transitions like TDISP shared/private, so
> > there has always been an expectation of bind/unbind.
> 
> What, why?  What forces that decision?  What's wrong with the proper
> driver for the hardware being bound automatically to the device?

It would be a proper driver, with a real match. I would expect this to
be done with sysfs driver_probe, which is like bind, except it doesn't
override the matches, AFAIK.

There are two sort of related isues. Userspace is in charge of
sequencing the new PCI features like link encryption and TDISP. They
have complex authentication policies tied to them so the kernel can't
reasonably do it. These features change how the CPU does address
translation, effectively it adds/removes the iommu - and that can't be
changed while the DMA API is active or it breaks every translation in
effect.

So.. We need a gap a system boot when the driver is not bound so the
PCI stuff can be done prior to driver_probe, and a gap if there is a
PCIe error of some kind to do error recovery and go back to the start
to reauthenticate and reload.

> > For this case the existing sysf drivers_probe is good enough for bind,
> > but we must have taint-free unbind for PCI devices too.
>
> Why?

See above. That should be the easiest thing to ask for! PCI is hot
plug, disabling unbind makes zero sense from any way you look at it.

> > I think this patch should be reverted ASAP, it is a pretty major
> > regression for a lot of users.
> 
> But this use case hasn't even happened yet, so what would regress?

I'm reflecting the other commentators, I care about VFIO too. I think
tainting every hypervisor is unacceptable.

But for CC I find myself one of the maintainers for that now and many
people have been diligently working on this bind/unbind direction for
a long time now. If it goes away I have no idea what could replace it.

Jason
