Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570954B4887
	for <linux-modules@vger.kernel.org>; Mon, 21 Sep 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004833; cv=none; b=P4uuultKVC8BC3L8SgSGvQPyhNSEjDvTVLNepwUbAzy5O/wNDIvYbvDp+Qrx6eGhTknvAmujAZhECzl+3c0wpqBR6bZ3EDfbcZ3YZF3pP4o7zk91p0DL16nLJunObxf73++lmfJOEUOlwES9JlGz8b05cI4ZB7MhUetCzdXISao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004833; c=relaxed/simple;
	bh=I7UesNNzihhfUM3T9kkjRfplteVqAEnYJpPI/ePgiEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNW6mc5mjTleOIV44cUFq4+aaRkkFgEQwZ20YakXYXgkHOS3FGjeNj3zWB6grSsiLUzH/QHRYn95sgyjb9bhQWqk1hsyO3tkbdKRvQjtFpXElz9Acfiy1DZjG8cV0jGttx+d68M9jC69BNokH9K7JXZaedCb/TyjJo91kABBfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz0t2q82; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz0t2q82"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c3so2473063f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 21 Sep 2026 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004829; x=1790609629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATQztYCMyMu3k6DnS/zHcGXiDiuEanDgsZ8XIDNR40k=;
        b=Dz0t2q82wSX3pw4NUPNIMWFDFyaMLzrpHR3XlMeTROMDG6hkfv3lKtMy+t8UX4DCYZ
         Yre0uZY0ohhZB/m8uZy+7NKSld+RQl4WeeH3lKWxRJDlI0jTU9kTZYktWnVPoRcdO0tM
         O02PStEdyvZA/1ewe3YZi37vUbtncXVXn3bg/EPbqaWhOYHpbpwP8SIbHTRblKzE9q7l
         nGBRSfYcad+DgIL8MobJBaUsECApzuOnQ/nsRfROKkFu03Gms5lDbF3Tihr3PUiStNA7
         M0LzqB6uep7UWHhTP43YO6bWVcjxoa7FsoT+/mFMmL/xcKoHjtxanaXNqCzWNQDUnag3
         +Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004829; x=1790609629;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATQztYCMyMu3k6DnS/zHcGXiDiuEanDgsZ8XIDNR40k=;
        b=xdThdyGnSktUhaDXVAupC0kMcKo+utGP8pS94+QDO6GeWM0tg4PssVnE0G3I4p1bWW
         TqAKjsnUbAv7XYAjF37enGQbaCtxTo7u5Ciq/kJDr30+k3dAYC2LjWpkdQUfKY9sUOzD
         606N1qrB2p9Fu8E7O/DgBuVOOE4OeDh2s9JDcH8VL9hMJD60WfBW9xH/vMJh8CBz9GWn
         nbVbktKla7nEpHRbS0jmg58I7vvxvr2NYv0Y3wr1oGdbLpJJuTPZy8jB3ORDRmS+jGrU
         WPJ+kSTCik2SPtTtGcnqIUWLJ61DOSDWKK0c8g7KApfzW0xtPkE3Kniv9fJ6FEfzt0wv
         aRMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtYGQWc79X0Yliqij/huP5ViwvuakVCSiUFv9Xb+IIquOQSYgeqHa1HnyX7e4eq/Za1GBWLe7W4wjeZ1WC@vger.kernel.org
X-Gm-Message-State: AFuF++nmh1AoyDf3uyt9sGMhvRB1LGdemNV0JelaEMUWW+0JlRnyxOlL
	UPaNOYsXKMZtI7CABtt0RZlOmqRjUn0kOR0Wl5y/2n7sfqTZl5UVJbiY
X-Gm-Gg: AYBFou23zndL8AnaiToNE1icF/GyhayhPcw5Asef6TgfDbdjjitIXvrt+1JZtvMKNrj
	Km0JTh9CEGWsBsZoP88i2gqyLM2Z2qcDetgmxmKNkABLLBk+ToPOnaewQpuueWBdOlyaAE5kLNM
	dveK7ANNng8p+hnfa5iURQ7h/VOAmGhHNdgY4GnL9wIsLOLwPYbq7Ri4Km8FZmDn/FUYHzvul6D
	xQI/OfF8iL0uOumBU8GUEp5H9g+ie6IL5o+DTSrS7FOOzrGbBZIyWoujlNvObzeETHtiHGiP5Qm
	PrBzg+iU8DB0o7roT7MxFxkCv2K7cXeT4eub9PsK0IcVGWCuariFHlsVwDaEv/JYgrLt3IDVIom
	nrtsL4FKU272oLe37CXsFCFdLbqQiCy7BjNx7ndg88fFcG9KAiVoNM6MXaFX0bbfrFW406GM565
	bmp2+q0gKfTnqeJ6MP0mSoTj2wmGWKuDfdnM9IN9/dMQG04Yg1Iz2DaG1dd+f/8vXToFujuk+eW
	LRyYOmLOx9N8KlnA4xT46p0bwNOpCAQR5DH
X-Received: by 2002:a05:6000:38f:b0:487:c48:5dae with SMTP id ffacd0b85a97d-4871e21d900mr14510363f8f.17.1790004829281;
        Mon, 21 Sep 2026 08:33:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872446067asm24137495f8f.12.2026.09.21.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:33:48 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:33:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, "D. Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya
 Jayagond <sidraya@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>, Alexandra Winter <wintera@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>
Subject: Re: [RFC] module: init-failure path can free a module with live
 try_module_get() users
Message-ID: <20260921163347.2630a6f4@pumpkin>
In-Reply-To: <2cd4adea-9b70-4951-be8b-40c1bcc7ecd6@linux.ibm.com>
References: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
	<20260918142241.55a6630a@pumpkin>
	<2cd4adea-9b70-4951-be8b-40c1bcc7ecd6@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Sep 2026 20:04:10 +0530
Mahanta Jambigi <mjambigi@linux.ibm.com> wrote:

> On 18/09/26 6:52 pm, David Laight wrote:
> > On Mon, 24 Aug 2026 11:43:46 +0530
> > Mahanta Jambigi <mjambigi@linux.ibm.com> wrote:
> >  =20
> >> Hi Luis, Petr, Daniel, Sami, Aaron,
> >>
> >> I'm writing to ask about what looks like a generic module-init failure
> >> lifetime problem in the module loader. I ran into it while working on
> >> the SMC networking module (net/smc/), but after several patch
> >> iterations, it seems the root issue may belong in kernel/module/main.c
> >> rather than in SMC itself. I'd appreciate your guidance on whether this
> >> reading is correct, and if so, what fix direction would be preferred.
> >>
> >> THE ISSUE IN do_init_module()
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>
> >> include/linux/module.h has a long-standing FIXME in module_is_live():
> >>
> >>     /* FIXME: It'd be nice to isolate modules during init, too, so they
> >>        aren't used before they (may) fail. But presently too much code
> >>        (IDE & SCSI) require entry into the module during init. */
> >>     static inline bool module_is_live(struct module *mod)
> >>     {
> >>         return mod->state !=3D MODULE_STATE_GOING;
> >>     }
> >>
> >> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
> >> can succeed once a module's __init is executing. If __init makes the
> >> module externally reachable partway through and then later fails, the
> >> failure path in do_init_module() appears to do: =20
> >=20
> > It is rather worse that that.
> > If sock_create() auto-loads a module (eg sctp) then nothing stops a sec=
ond
> > sock_create() entering the protocol code before the initialisation comp=
letes.
> > That can be hit by two separate applications, I hit it from an out of t=
ree
> > kernel module and avoided the problem by putting a mutex() around the
> > sock_create() call.
> >=20
> > It might help by letting try_module_get(THIS_MODULE) always succeed
> > while blocking other requests until initialisation completes.
> > The code making the call must own a reference (otherwise the code could
> > just disappear), and that reference stops the module being unloaded.
> > That would let the initialisation code grab extra references (eg for
> > a worker thread) without allowing other codes paths enter the
> > part-initialised driver. =20
>=20
> Thanks David =E2=80=94 you're right that the race is broader. This patch
> addresses only the UAF on the __init failure path: once we set
> MODULE_STATE_GOING and call synchronize_rcu(), new callers see GOING and
> fail; we then drain existing refs before free_module().
>=20
> The concurrent-init race you describe =E2=80=94 two callers entering
> MODULE_STATE_COMING simultaneously during a successful init =E2=80=94 is =
not
> addressed here and would require changes to try_module_get() itself, as
> you suggest. That is the long-standing FIXME in module_is_live() and is
> a separate, larger change.

I suspect it is also much more common.
Module load doesn't normally fail, but if you can persuade the system to
unload an unused module I'd expect a non-root user can hit the concurrent
init race.

David
