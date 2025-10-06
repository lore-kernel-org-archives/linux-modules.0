Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E619F111
	for <linux-modules@vger.kernel.org>; Mon,  6 Oct 2025 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791497; cv=none; b=diK/BLrBItnYBtOf8xFM5IBmzaVFG5B/bo8jSm4EnOPtsF5TGu2P4KefEQTdEicydmcVg3YGGX+IzFDFg1ZTd8P//xxSo/FqvL9TlsZbvDfsqFLEM+Yf/58pgG481TRD/Plhzzs8heNJzYbBIe+ZbqRDThb15XrkekYOgdxGv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791497; c=relaxed/simple;
	bh=Lxcy5NL3Pu34Y9yZDrN3rk4ENVzLB2VJ2gFBFJRiZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kssy0Ip+qqxTaiI24yb858ZLUK8MdqCeuVdZgPTBm4Y7eRrEURIqZDnDo9BvRwg8R5K3wn/0vwvznS9hq7M8CTQGhmTg0LXMMMPZ85i8fCItWW6EHyhDvVusH44pBMaRxLJWwcCcFN1w5ggWyRCUMVwu2m0CPaOJ1n+Ho0SlsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M4kP3F8h; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4kP3F8h"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso5498382a12.0
        for <linux-modules@vger.kernel.org>; Mon, 06 Oct 2025 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791495; x=1760396295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/BzR3xcFJ27hJdoJBLSQ8cx3Y7ne92fXQ6+nL97RBI=;
        b=M4kP3F8h1g2h/2LVC8k+gEdvyFalaLxxhi0boU2ms9csn7D1qhDuu9DZhemPuTizfP
         LkiecPIxTfoI3hrpGqKq/4xfGOjtP/078WK/I8tW/0Idm0y75by/92PZg3m0dhXB8/sJ
         yq4mBd5DO7cgp3BIdIRP3Wg7rdfxJg+brrp4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791495; x=1760396295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/BzR3xcFJ27hJdoJBLSQ8cx3Y7ne92fXQ6+nL97RBI=;
        b=i8E9yA4Ef5xWS5+EN5FomASc5vF36oqxPdebxBXa3FNWQVyJodYSt+m6GcMvWEJ4jB
         DYSoyfHK3wCiMb7bLuuH5pDos4ohDOe8sy2WKgfd0lcNTWAa8aihV3rHPY6Z+JWgwMO+
         jfcimUo4APrIi6PekuroNK2Wn97fK1Cif8cnlatPA8ajYLUv9NAfIZTcmQNOOt9VYJTV
         nfooUmHCZOftFb95f1OE3PJh4k6g1V/AFPp+8DnnvtXEuTdmZ8gsa1FzkDVIvo+FdWYK
         Qv3vAuZktCg+QoHKmvZpKhvKRyiw1YUOo570mRtoBCdKEBxIuY3SVmEngFWG+Tyd4FNd
         E9Og==
X-Forwarded-Encrypted: i=1; AJvYcCXA8rb7gq36ve+kG1a5GWqT7HL6Uwoz8MfVby3vdAaWE0BfyyUpdQeVycsAJjcZ/TNUFXA3NH3ayqTHy0LW@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZb+OfQnqgzyT3y1Z4Ndwz/rFW9YRk6ztOE11sl+kQXsCwjkS
	JYQpqWw96gNUUNaTgHCzszDsbrz4d9WB3AaXMRTx8CAZoboh262HCcwggaKZSjxp7A==
X-Gm-Gg: ASbGnctAAp75rmbAzLLKz5H9i7w7xN6JtRpFDa5OB94imMdg0A2XJQsj28tAs6F91+v
	nsBF0Kmsg9wcC080FaakxAtBOd9n1b3oZDMD7RwpnAtBtQWzg/JxIvZ4NyGc3Zztr/oS/qJLd7M
	GAHcljsthnpRNgBaXZqe3tK/bL+rObx9JDv0al/Q2wkWitUY07oM1Sm2i6w6fZC+hI33NTKEd7g
	GcSBsFqMhnkDhm4v3n4+NN72ARSnjGcp2W7WSGuQfFmJsGRoCTvyrDA0BFpiskqPL2nfSlSZECv
	7SM0onuwT4myOl2FfKE9wz7DAHlQZ+Gdl5n6m31zWEeLXrhPpR66xGE1RuXVovU669pirLNhdYv
	30L+BWQl70JD45AAubEDi1QzqXD3JtcPc/FsXm77qM1droNsZqhvW6V0wP9ltyadBkTaHcDNcGp
	2os3OzqZ8F
X-Google-Smtp-Source: AGHT+IGVZN5motWy2Ycd10vl3SQ+AaFTmr4hj0xbObvYJTiiiEPPzlHnJXWtgHFm0rxdlAP5PbSCnQ==
X-Received: by 2002:a17:903:2ac3:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-28e9a679f43mr160020265ad.46.1759791494873;
        Mon, 06 Oct 2025 15:58:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:299e:f3e3:eadb:de86])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1d5e20sm143991805ad.97.2025.10.06.15.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 15:58:14 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:58:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Message-ID: <aORJhL1yAPyV7YAW@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
 <aNLb9g0AbBXZCJ4m@google.com>
 <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>

Hi Petr,

On Wed, Sep 24, 2025 at 09:48:47AM +0200, Petr Pavlu wrote:
> On 9/23/25 7:42 PM, Brian Norris wrote:
> > Hi Petr,
> > 
> > On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
> >> On 9/13/25 12:59 AM, Brian Norris wrote:
> >>> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> >>>  		return;
> >>>  	}
> >>>  	pci_do_fixups(dev, start, end);
> >>> +
> >>> +	struct pci_fixup_arg arg = {
> >>> +		.dev = dev,
> >>> +		.pass = pass,
> >>> +	};
> >>> +	module_for_each_mod(pci_module_fixup, &arg);
> >>
> >> The function module_for_each_mod() walks not only modules that are LIVE,
> >> but also those in the COMING and GOING states. This means that this code
> >> can potentially execute a PCI fixup from a module before its init
> >> function is invoked, and similarly, a fixup can be executed after the
> >> exit function has already run. Is this intentional?
> > 
> > Thanks for the callout. I didn't really give this part much thought
> > previously.
> > 
> > Per the comments, COMING means "Full formed, running module_init". I
> > believe that is a good thing, actually; specifically for controller
> > drivers, module_init() might be probing the controller and enumerating
> > child PCI devices to which we should apply these FIXUPs. That is a key
> > case to support.
> > 
> > GOING is not clearly defined in the header comments, but it seems like
> > it's a relatively narrow window between determining there are no module
> > refcounts (and transition to GOING) and starting to really tear it down
> > (transitioning to UNFORMED before any significant teardown).
> > module_exit() runs in the GOING phase.
> > 
> > I think it does not make sense to execute FIXUPs on a GOING module; I'll
> > make that change.
> 
> Note that when walking the modules list using module_for_each_mod(),
> the delete_module() operation can concurrently transition a module to
> MODULE_STATE_GOING. If you are thinking about simply having
> pci_module_fixup() check that mod->state isn't MODULE_STATE_GOING,
> I believe this won't quite work.

Good point. I think this at least suggests that this should hook into
some blocking point in the module-load sequence, such as the notifiers
or even module_init() as you suggest below.

> > Re-quoting one piece:
> >> This means that this code
> >> can potentially execute a PCI fixup from a module before its init
> >> function is invoked,
> > 
> > IIUC, this part is not true? A module is put into COMING state before
> > its init function is invoked.
> 
> When loading a module, the load_module() function calls
> complete_formation(), which puts the module into the COMING state. At
> this point, the new code in pci_fixup_device() can see the new module
> and potentially attempt to invoke its PCI fixups. However, such a module
> has still a bit of way to go before its init function is called from
> do_init_module(). The module hasn't yet had its arguments parsed, is not
> linked in sysfs, isn't fully registered with codetag support, and hasn't
> invoked its constructors (needed for gcov/kasan support).

It seems unlikely that sysfs, codetag, or arguments should matter much.
gcov and kasan might be nice to have though.

> I don't know enough about PCI fixups and what is allowable in them, but
> I suspect it would be better to ensure that no fixup can be invoked from
> the module during this period.

I don't know of general rules, but they generally do pretty minimal work
to adjust various fields in and around 'struct pci_dev', to account for
broken IDs. Sometimes they need to read a few PCI registers. They may
even tweak PM-related features. It varies based
on what kind of "quriky" devices need to be handled, but it's usually
pretty straightforward and well-contained -- not relying on any kind of
global state, or even all that much specific to the module in question
besides constant IDs.

(You can peruse drivers/pci/quirks.c or the various other files that use
DECLARE_PCI_FIXUP_*() macros, if you're curious.)

> If the above makes sense, I think using module_for_each_mod() might not
> be the right approach. Alternative options include registering a module
> notifier or having modules explicitly register their PCI fixups in their
> init function.

I agree module_for_each_mod() is probably not the right choice, but I'm
not sure what the right choice is.

register_module_notifier() + keying off MODULE_STATE_COMING before
pulling in the '.pci_fixup*' list seems attractive, but it still comes
before gcov/kasan.

It seems like "first thing in module_init()" would be the right choice,
but I don't know of a great way to do that. I could insert PCI-related
calls directly into do_init_module() / delete_module(), but that doesn't
seem very elegant. I could also mess with the module_{init,exit}()
macros, but that seems a bit strange too.

I'm open to suggestions. Or else maybe I'll just go with
register_module_notifier(), and accept that there may some small
downsides still.

Thanks,
Brian
