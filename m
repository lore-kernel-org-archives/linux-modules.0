Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8437BAFD
	for <linux-modules@vger.kernel.org>; Wed, 31 Jan 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708757; cv=none; b=CN8nGqJIfhK/497Ekwzd2QNhxwj/s01GwPHwj+rF7yfyJFFva9imxcwwKlKeC8WO38ma5C1ej8VOYzRG6c5SSaB6z37FQZdXziHLzxFmuDlU6mVa+YFhV9bo0Jx87qELywBgLI+HmuYsdym4uz7B1rML9iIynzzlAbKBg5kiKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708757; c=relaxed/simple;
	bh=YT4VNlZErtDsWMJ1q49eQYYIbFgY0O4C0h9c1hT2BrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgqTq5Ss8E6194CM6SBZY3DMnnl5f3pgB23OZSxaXRIiPyKdavqAAHsdBB5Q2+dPEQcdDA2RvZR2+0QrGRD86Msd7kGmxFaLjaBI6VIrbjDPUNuXfkJ2wei+rwM7ms0vvX21xxqPFPmrzLeSe6CoGB6OYrgR5taB/vsFkjXEtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY90yNi5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY90yNi5"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60412866c36so3491417b3.2
        for <linux-modules@vger.kernel.org>; Wed, 31 Jan 2024 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706708755; x=1707313555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/BFngCnXq1aNpriehRcnV9nNDPUoAYjKjo863wTMao=;
        b=JY90yNi5E2gVIOYJOFa3cyv6cUUMZlVDeUQMeHbbaK1kA5aYUEVu6a0NwTuiownco7
         0/X2KBgik+QVnIipu3PmDWJsCDJM7ppZeVEwO1etbimX4wgoV27M4/MKuhv5Z7jX3TiM
         6/awbeYN+LGFz/X0484XokK+iMPspxrIm7qzQDoXOROWLDedgaqWAeAkHKO4D+73bwAj
         Ei2YXI7ektVFdzWvS8msen/bepju3bsHTW4PtrSJCuEX0QWH6cedmP1LGY68ph7q4SpR
         lALyJ+UBpl7VNMEGU5WbB126atPIzeWOp1xD6JHJeLEsRBnETb5zSIpgqOjZ9nsjPY/Q
         16yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708755; x=1707313555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/BFngCnXq1aNpriehRcnV9nNDPUoAYjKjo863wTMao=;
        b=IglU6Ocet8/lHNkGmusrLZa1KZoOVT0+4niV4B1DjqPjDyP6uzZFICdJ6UKCj/XUaW
         c4AO42xihsvvL7cHDwoxbBxpV9LZsXR8itQ/4SfHfDVgosr+IKMPlqjKUG7Fx6nHpzEC
         I+0/GAhs6A/FXrKJ9yuQ0cfjOeZxnYtwg6Y3pNCKv+dVLmuj/yzv6BvIqb1N1hfu6It0
         lZB3/OIYCtHdTRykLIIATgOTkUgj6etHFZhtiu3cI+rcfkOX8lZFgPtbVK8Y4ojT8lpX
         dxEPDv/2m8xX5GztVuh+pS5tz32bFUMPodT4mzlYOeo5MOPUBc9wCBDyEEil8meblZos
         ytmA==
X-Gm-Message-State: AOJu0YzpBxyfI9zXaoXwcBc4kaZmLRi84d2EGTq8Uf+5rTo84v4C1Ts5
	PMak1qERcKOGxQ+DOgNkyZT/8IOviJwi9HMQ5dYm8Wiu0j6Gk6GUqDdsYkvI/0M9oyIgAHKErc0
	TJL2/5Q69Q2i7bSa3aYLnCT4RY0o=
X-Google-Smtp-Source: AGHT+IGNkmZJiur13AXOdDmsywfZw3s463BrEqoA0ExLH0LM/0kZEdKiWfo18gzJYX7eNlmdQUKZF1ky14vxIDH/kG4=
X-Received: by 2002:a81:77d6:0:b0:5ff:6026:2787 with SMTP id
 s205-20020a8177d6000000b005ff60262787mr1412057ywc.1.1706708755083; Wed, 31
 Jan 2024 05:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-master-v1-0-6257d039a30a@gmail.com> <20240126-master-v1-2-6257d039a30a@gmail.com>
 <tdvymg3uuvkns4uqvivvvkj7sf6pqr45rpbyqmngaf3jmvqije@fsuvyu3kai54>
 <CACvgo52Eb1MV328RPUPLDq8cPO+7NvHn70q3SQdiTr_apnE5dQ@mail.gmail.com> <wqvtxyw6h6mcdnqv3cv4kzorlck3qzcb4p3duq6m3w7lm6isxl@kupxidkj3x3w>
In-Reply-To: <wqvtxyw6h6mcdnqv3cv4kzorlck3qzcb4p3duq6m3w7lm6isxl@kupxidkj3x3w>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 31 Jan 2024 13:45:43 +0000
Message-ID: <CACvgo53aataYSQD6jmz-+sr7s4ZoEv0WAqVM_LDxwzcecN8BwA@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>, 
	"Marco d'Itri" <md@linux.it>, Eugene Syromiatnikov <esyr@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>, 
	Yauheni Kaliuta <ykaliuta@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 22:09, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Mon, Jan 29, 2024 at 05:23:44PM +0000, Emil Velikov wrote:
> >On Mon, 29 Jan 2024 at 16:40, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >>
> >> On Fri, Jan 26, 2024 at 02:43:51PM +0000, Emil Velikov via B4 Relay wrote:
> >> >From: Emil Velikov <emil.velikov@collabora.com>
> >> >
> >> >Currently we create symlinks like modprobe (pointing to kmod), during
> >> >the normal `make` build. Although those were never installed.
> >> >
> >> >Add a few lines in the install-exec-hook, to ensure they're present at
> >> >`make install` time. Thus one can actually use those without additional
> >> >changes. As an added bonus, distributions can drop the similar hunk from
> >> >their packaging.
> >>
> >> It was a long time ago and my memory may be fading, but afair the fact
> >> that distros were doing it was what prevented us from adding the
> >> symlinks ourselves.... and then we never re-visited this.
> >>
> >> I'll dig some history before applying to make sure I'm not forgetting
> >> something.
> >>
> >Ack, makes sense. Fwiw I've already opened a MR with the Arch team
> >highlighting these changes.
>
> no wonder my memory faded as it was almost 12 years ago and during  kmod 3 ~ 5.
>
>
> 00fc926 build-sys: create symlinks instead of building separate tools
>
>         when we started using symlinks to a single kmod binary
>
> 7bbf523 build-sys: create symlinks if we are installing tools
> 12fd9cd build-sys: forcefully create links
>
>         when we started creating the symlinks
>
> fe8b067 build-sys: do not create symlinks by default
>
>         stop creating the symlinks since it was not working across
>         distros and creating more problems than solving
>
> Now that distros configure all the paths through configure options,
> we can probably re-attempt this.
>
> Cc'ing some pkg maintainers
>

Thanks for the information. Curiosity got the best of me, so I had a
look across few distros:

Arch - installs kmod in /usr/bin, symlinks are in /usr/bin.

Debian - installs kmod in /usr/bin and symlinks are split across
/usr/bin and /usr/sbin. Cannot find any references if they're aiming
to merge /usr/bin and /usr/sbin.

Fedora - installs kmod in /usr/bin and symlinks are split across
/usr/bin and /usr/sbin. Fedora 40 is aiming to "merge" /usr/bin and
/usr/sbin.

Gentoo - installs kmod in /bin and symlinks are split across /bin and
/sbin. Gentoo has merged /usr (/{,s}bin being a symlink to
/usr/{.s}bin) and merged bin (/usr/sbin is a symlink to /usr/bin in
some instances.
The https://wiki.gentoo.org/wiki/Merge-usr wiki explains the tool
aiming with merge conversions, although it seems to be optional albeit
highly(?) recommended.

TlDr: Distro variations still exist. Arch is fine, Fedora 40 should be
OK. Debian will need an in-package tweak. Gentoo will be fine for most
or at least some instances.

Personally (Arch user here) it makes sense to land and release this,
alongside the /usr/lib/modules support. Although if you think it makes
sense to defer for a later date, that's fine with me.

Regards,
Emil
