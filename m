Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872282;
	b=JMYnRcZ85qT4/PTOFbmBJJjJ6jhVTWavPQwcCnrcS2bnLybEq/hQRONOCCTOBeoMuGni
	 XA8jIGvuMRKobdFydrWv+B7jVfwWWLETHGS2F6dqNIXZK398crkQLO0AY/xYKAJcqRRMw
	 Lip542wwDHqJp5jiSxIpNjWOu7oyBrdfe1OtTfAHtw9ZqunDyjJTuEdkYfqXwXQh+itLM
	 u0jWtFixD0YA9GwWgIpK112YO+47DoZumo3cy9qzjV/t+SY8h5d/GwxsLxnpEtMfKr8/p
	 5VvAxiQCh1OXi0rfAJPOFMkbooNl9k0irfcH32ncLoZG5G14JvFUC+t2JsZGGdceF3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872282;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=qGP2/CbMlHtGHNu5eknRVDLcutRXriMBMU+ucjLI8mTIvU1TbmvEOPY4VMteWTxxOsuV
	 jwAM1GWWgGb8MbRlAkEk/xWTqsIYfbX9HoQPwAMJhhUO663hdUYQPSx5n2ZIN7oW2HUCI
	 icGwKe3OIw8XcDS3UaA9fCycvmlVxMPdk06SkfkZ2zWGWUCfa6wXUhm36AuSmDr2ZXwHo
	 gdHFxGy9j8nNt/bqHOiY77sDZmmyTWv3Tn5+ZuQxnqShsdU4+hwQPqPz4w+PRqlszQfLr
	 cLP/RQJD44XDDER4k5joFsYVXkhBuTV1s1sMSVPnAppQgIK47xO+6NuCA7Hy8PxSEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD256606A32C
	for <linux-modules@vger.kernel.org>; Thu,  5 Nov 2026 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD256606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53653e30353so21927141cf.2
        for <linux-modules@vger.kernel.org>; Thu, 05 Nov 2026 01:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872281; x=1794477081;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=ojWPoh3D3UV//8CPJJmwYV2cV6O4xZuty+x7h7IUFWo04Mqc/Q9UOROuWSUDqfa4B+
         TxR7RlXRn2LkZ62R8ZzLvPqjulZVzBR1CyCTyLzZ/cmm89orMUjrDNyfbDv4I4y8dYhU
         UptftpBxbTwxTRGMjvdDRKD/RvFRUZ6E2U1cIKLXslKg59JSnheAgjWbrSXDA3NeFnkb
         RXl45f8VSismEL61yF7WgHaf2v1VnEjsLA76H91nFCKYVhOMWWFXvzIQ+KNPjhqrPlt/
         llmu+p2UyqpSpn67UyWl9tHyJSmKSstfaW+JxkU0EBwal1EKN0I3HjCsrsEqNbyMISt/
         KuAw==
X-Forwarded-Encrypted: i=1; AKwUvBxqTAjVwORQhDW6B5y33Ssk+s9YGY5h3/5FDOr4NGlfk11ceOzWhepSG798cd0PmwgHGZSpI69wcjF8SHfu@vger.kernel.org
X-Gm-Message-State: APuU4Z+m+bJzSs3Z+r+c+5Z6kC2pW+sL6GLOzN3ZrOeyX+tbqdBFZcuX
	BjPoXf9Lcqy0+xwlrpqeAFpqfRX77jypl4Hbax+kXZjs0hUKBn+uMf48RXaDNh1KIQI=
X-Gm-Gg: AYBFou2Kd68HD13RpGB2iL0b8rhbLFBRZb5LfSvJo5PxljP6YljzK/M2b3DVdtaQDom
	Mcqma9Tj4LJCKw0re+G11OS/QtkXlvjydMaT0sZNzajXwSUxV27Lr9jcgy+yBU9kv0NGEEH3m+E
	Axti08tLM/oMmzkupsy/NofsQAj3iJC38spDtQWJcg64O+STw2GhnSjIurpCiDT6vNc2JzRo19S
	EO6OCxM/I6x6JkAAzyjgplTQ9js28Y/qM7C4KR+vWSccQHpjY8B/kvM0pzqJFry0dMfmsXFNJ1x
	mmuROgx5P11n3hOKQb8+X8DRbOIyb+QlvzxvBuqpyS89+j2wy8Vrek49nYvdLhKcZFx5mwGpldN
	6Upci845Oj0y5HRf3yxWsSdLGi1woE1D4TgM97SI91TrS8oSD105GuKwl0zRLreIE4bad74CYmp
	qRwtaVXH+pLEnGm1HX+YzyRIUpIf7M0ggLpTUFAz7yct9aGMEd70tId1CgQK4AdxV2dTgomfYX0
	BIzR9DbIenHOXW0IAGcqV/nbOv1UyXM7FaRv/3/jI6Bz15nYeIot8ZK5VMomRyKQQe3GbD4ucj4
	YzP8G+nt3jVcmHmOaiBBCmEoJg2xjkz7hc5kHqRmNLtOxawW6jPBNwqX6bovJ/KxdwNIVg==
X-Received: by 2002:ac8:59c5:0:b0:537:af99:b562 with SMTP id d75a77b69052e-54d315cad19mr8977211cf.47.1793872280721;
        Thu, 05 Nov 2026 01:51:20 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dad276csm43321726d6.2.2026.11.05.01.51.20
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:51:20 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f3c8958d5so187520585a.2
        for <linux-modules@vger.kernel.org>; Thu, 05 Nov 2026 01:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzcdzCHTdwCf39qDsdU4HNaRPvDTmAg+qdDavJEWWH+Sq+e/UfVfAgEH+qNcQRvhoNeyTgKC9zQbjNeldpt@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
