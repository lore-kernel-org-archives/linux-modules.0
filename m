Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080993;
	b=qpCG1+LguDS3SjSl8Q6YVMhNKpoW/LuL6cK8GVlZ8p+yn8lQzOzxkvB0OP80v7p/Ou5S
	 AAyhmaeaOZA5iQdIvsKD7M6k9c7ecicHEVLSqWVnYeqVntBXvscMCexPEYhSfEe+Twnh4
	 vdMZXFu9REtwHK+oVZu7GQShlYKmOocQH+DQA8IaaP3TM+FOS1MLU1GnRsD9B7xIM7hxM
	 dfr5D6p4oe7WMhAfo4Mkx4Hinv+9T6CRqZOzIMPgu2fmjoQBLFX/txnScqY2ar4d0/WtV
	 3DkpvbV+5VpTy2uqF5XTYZkqwJzxztfRnarzmkgUSElngkxFYDk47gydBWXgF/E4fHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KtHkcu0sQsAK751caVzJBQDY0o4i7F/zlOnjMPPeE5I=;
	b=CnnIBv5HDxqCeOdBZvqv0lguwDV43eU6AUCneMy9atFHUXo6H+49n3fi4kVn/LKs9zLA
	 pwxjnNNQeSyVE3q+9ipmYeJT1Ze55Rjg2YdLHO9CCnhWuSN/g0sC/wwZwECvkxTgujgPg
	 TGzESbRUhYP0UvIILkVMBpyNfJU5FP0MFagL5Ps2znLTnSgMrL8f4r3XY0PkboFfTWk6i
	 H7EJ4HPmw7NNeo8NVOM/q7MQ3Mg1zeAKwD0J4ymGuQh2Hy8Pg+DE0lsIB9fMDwuyx9huA
	 0fvn+kL71a++ZaxlFtEhpBEmpN1ZiF4ePs35K1cYzSpcpOvFUStoa+6IqKcfBdMcDDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fd+rVQCT;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0E606A31E
	for <linux-modules@vger.kernel.org>; Tue, 27 Oct 2026 06:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE0E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fd+rVQCT
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a210470b49so30311105e9.2
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793080991; x=1793685791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KtHkcu0sQsAK751caVzJBQDY0o4i7F/zlOnjMPPeE5I=;
        b=Fd+rVQCT6h6iWDR02V4pfE6w4B9VB1S0lffsv2IDdIHHIRdyK3jUEt2FmHBfZxMBXo
         /6CAn9UDjbhCtzDFEAD5X9jRnzYGPQcAkOmikfnG13ul8dm2gAbZsM9KyfdVDLAcz/Ay
         UiOYwyOaUeF+/xVxB9iMXFcDyDlueTVmMgBFt8QsaC3JgphcNjaakCDKqO2hcesvrHWK
         9oqTpTZC6ExZY6JzDB3EJe6w45YuoOXY55hHfzjgqADewKP+nXACtXCBTHV/WG0pE4Ke
         YqA7i+Nq+iwiszDPQZGl2GpPWw21M4pwSa8W/8EODi1AZRQE76335KaE1hQ2D2r+gA/7
         74bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793080991; x=1793685791;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KtHkcu0sQsAK751caVzJBQDY0o4i7F/zlOnjMPPeE5I=;
        b=VsKFFlujT+It/hZgQKRcaTOtufieIGvY+ky7kauCAi7WHc2+0rNqMYzkyTiXuSOCap
         8TQ/HIAGF8pVsK1hNabmw7gtWSgSbuKbK1IFNcllu/+83gSrmwRnQchkOYsPvL3xh5ow
         wRAMYRDCnkuXbPa6CJMTLL51sEKBbU0tKcC7YaJmqmWcuFChC7UIUC4cbExI7II7fv4F
         bYPIuEhBRLiCRoVmGetDyxJoMX5t1YTr+WmIQd9sSEdbxodUbrEW/0zV/xKmQQ+Fj0es
         cJDc2LOfRqNnE9fbXcIuZN34A/aHBl2wxLl1hmdt3OAlg1d/C1Bj9YFU6eQ+yeN2MnJs
         SbRw==
X-Forwarded-Encrypted: i=1; AKwUvBz6XzBCo/80FmShv7m4UsycRrHqjcdanpnceqS4xWQrpi3qEVxSSUvBvNVHFXfU0FSqOEsS7xDH0iHzBwBN@vger.kernel.org
X-Gm-Message-State: AFq9FYLtycjbndHbCP47mGH4a1CfFtIBkoj5niBLY5g7A+REElApAS8b
	MX8S1eWlhJCS/6XLoQoflKBFiij5BHtl+4rXrJLo48mjzJnuKKIV/HTV
X-Gm-Gg: AYBFou2uOmLGd0KIAowqEiiFUmYb4gWPAWrIsSDzqsV2CKEwYpeccTr8I0USVgK0Oew
	ofI4YqMzSgBT4ZZGqnN2s80lmQR2OqDKQwB/F4TAOWt/4cWkODyhDfaovqeN65NkzsM3k3hMK4R
	iqcWbJL0SEP+hC8qBNAF2/K8pw8shuoCU6mM85kMuRQVuyjOzThbInb8jSgCeweklrI2RCxHYsJ
	zG7Di2XxrOqHDoiajOmmE04bmoov2UYHE4XYZhNq+JQUZjixJqdTdEAU1mTFXE2XGAHgZKdyse3
	Xpy3seootSCwGFbi5q/lB48L+ofXXyMiJlipM2SBOE8FTv7wLiYo7DIIyJsqORQvzT6Z0LBjoQ3
	l26yBeRjTSgRmRBLAZhasWxTg+Ohg9zJAa5SnCUMcuLTAzrOS3UDP+EDDqAPNvMEGiH7sjD7Dky
	euzALiS951MRgNqrfKr8vileKSTzp1gfk7Vy4sY2kIq0xWQqMNobVtUoXrYdL6nlVkoQiNW/6ae
	F7jKd1jevfTvFrTYNiiiTLoAsuq4U5XyipFS/gNPY6Nk15DsF4F/9KeeAu9p7Sm
X-Received: by 2002:a05:600c:3acb:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a35aca4fe1mr159192175e9.16.1793080991458;
        Mon, 26 Oct 2026 23:03:11 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5698f1sm240600745e9.8.2026.10.26.23.03.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Oct 2026 23:03:11 -0700 (PDT)
Date: Tue, 27 Oct 2026 07:03:00 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alex Williamson <alex@shazbot.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, David Lechner
 <dlechner@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Bradley Morgan <brads@mainlining.org>,
 Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 Richard Weinberger <richard@nod.at>, Thierry Reding
 <thierry.reding@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261027070300.4c45616a.michal.pecio@gmail.com>
In-Reply-To: <2026102637-buggy-mothball-2a08@gregkh>
References: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
	<arIvG0nx4LXG9nlW@monoceros>
	<defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
	<9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
	<2026092321-province-yearly-44aa@gregkh>
	<arOfHEsGGglNse7T@monoceros>
	<2026092348-victory-erased-0e5a@gregkh>
	<20261023181326.0dc2f7ed@shazbot.org>
	<2026102437-vista-unsoiled-b089@gregkh>
	<20261024103512.4601ee4f@shazbot.org>
	<2026102637-buggy-mothball-2a08@gregkh>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 21:34:57 +0100, Greg Kroah-Hartman wrote:
> > Even if we could come up with a set of device IDs, it's a policy
> > decision whether a given device is intended by the admin to be used
> > by the default in-kernel driver or a userspace driver.  
> 
> Great, then have the admin never allow the in-kernel driver to be on
> the system, or be loaded (modprobe has deny lists) and all is fine.

As some maintainers like to say, it's not the '90s anymore :)

Users don't reboot systems to kick a kernel driver off a PCI device to
try something in a disposable VM on a whim.

Even if they did, it's completely normal for desktop users to have two
GPUs from the same vendor or two xHCI controllers and pass only one of
them to Windows/macOS while using the other on the host.

bind/unbind feature prominently on every distribution wiki and forum,
this cat is absolutely out of the bag at this point.

> > That means that at one point we want the default driver bound and at
> > another we want a vfio driver bound.  Coordinating this is exactly
> > why we have driver_override and, building on that, match IDs that
> > require driver_override.  This allows drivers to describe
> > themselves as vfio-pci compatible drivers via modules.alias while
> > requiring userspace to enable the match via driver_override.  
> 
> And as said before, that's a horrid hack and one that is breaking
> things today in all sorts of ways, which is why the taint was added.

Are you aware of bind/unbind breaking things for PCI specifically?

Without also involving 'driver_override' or 'new_id'? Everyone agrees
that these APIs used for anything other than pci-stub or vfio are foot
guns. But your patch targets something different.

We can even bind PCI drivers to wrong devices *without* using bind and
hence, I presume but don't care to test, without tripping this taint.

> If you wish to override the kernel, then great, a taint flag is added
> and all is fine.  All this means is that now developers know what you
> did and can decide to ignore your bug report or not.  No functionality
> changed at all.

I believe people pointed out that it's a functional change for users of
panic_on_taint who also use bind without being idiots.

Does this taint even solve a "real" problem? Those bug reports weren't
coming from users, they were coming from "abusers" like syzbot looking
for trouble. They were quite obvious even without a taint message.

And at least on linux-usb, they seem to have stopped after Google and
one other copycat were told to stop sending them, and before this taint
reaches released kernels.

I even told them to block not only bind but also new_id, so there will
be no second wave of reports caused by syzbot discovering that it can
bypass the taint by using new_id intsead of driver_override.

> Why are you worried about a taint flag?  So many servers run with
> taint flags enabled due to out-of-tree or questionable licenses with
> no problems, what's one more informational bit here?

And what's the point of a flag which is always set on countless normal
systems in the wild? If this feature survives to April 1st, I will send
a patch to rename it to "VM passthrough taint" because everybody (or at
least those dealing with desktop users) knows what it *really* means.

Regards,
Michal
