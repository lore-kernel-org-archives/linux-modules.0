Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872854;
	b=iSFVy2PSisQojNvrVW3ogjpr1arATyLSfrlPRza5hnlE0nyThFWBjqyf7YpYlzxP1pXR
	 VFganjTI0GWigui9odfcQ3J6Si121MSIenaJ0we/UBtwbu1y6DAko25IyhTbzn4Mm2o/K
	 B8idW0tyccp3rl2wEGcoQBhZ4ythiegaZaKtCuJLc7yjpGsbmnrFykK6gTPFQtnbphlhk
	 4ULVTE5gC6ykh5B/3GlpXZXQY2DzfIIOThxNcP8NVVGm9Rwl/SR69xXVgE8yyKuyW/f1O
	 H4BFvcSwuXo9zIQQNqVNxoHTk6+nMD+PUhM3mYffKN2qhWnRXoEnSuWSb0DFYQT64oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872854;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=q3IvO6Ahv4Z3xOYX64Pp3vTBMzff52HghAdJ0SSUfFz8s8aO74hIqxleHddLYYknlTFb
	 5719spi83PqvcznulVP6HRLgY+KGO3HaHy+voQd5ovSNj8SI/ZCBKZsrL9bJcBeYhGHOv
	 it2MXy6caf2bLeCm4gDgVWLDcFCkvKA123WqIyMCYlzyz/8YeH/sycWovakNsU+0eUnF9
	 13MzVw1XHyGVhFQfav/yWoXjxzjwMcBOBs6ZxLUHZTNonK/5GOwMgrjAzLGvh6/1tFZJb
	 9RyJZe2GdeViImU5fiqeR4DRaQJbPJtzo85C6UQi7LHJ1bqBw+C0Xha6t0OiB+ughmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061E606A328
	for <linux-modules@vger.kernel.org>; Thu,  5 Nov 2026 10:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C061E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c1f548f87so26525766d6.2
        for <linux-modules@vger.kernel.org>; Thu, 05 Nov 2026 02:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872853; x=1794477653;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=W1qcq7ZfCH2J1Cz1AURKRuJsc/P3nyrboOIXL1sPcb/OiKg2Md/EkKVPLRDUKCgtPh
         rV9iUchsDzClaASoNg0eCPiHxbuwOPvc8eJnEe0ZVLTdfHKBSVCYQsuTUM10eucNLpzB
         dXYx9vFYeDU9Yy7p3Qzw7n67K3EnJW9sJXEci4I+3+IRu1jFvvsmYT34gZG9hj3MTSHP
         UosglAgoOyU9LjuQaRArEjDkIlM4+vuksx8Xlij76AzhkvcqdnYurfSiH/zzfc+6n/FC
         UrBDEAt6j3O/ePEzFTD/7E6sik06a/RSQ6RecGzRpk+MQfYJkAYyortGM4hycFyLyIai
         cbWQ==
X-Forwarded-Encrypted: i=1; AKwUvByWx9/0k2ccyYmUx1o0EnJr9jiMTZBjxUEEyX7qlAOy7Snf4FnEG4zz9lb48vwkkYKYwO9KRXc97gkUdiKL@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q3ut6McHgDKv/+pcpepHGeHh6/oJKxUZivT97X0PMZO6iAcoB
	tNsLBCYOWia8wM2NO9O0cZXpxzVUhahVHWJW1R9ynxV0bvYg3J9Uwb/zL18Gbu+mGXU=
X-Gm-Gg: AYBFou0MFfwaDQGp9eg6usN8vv6jjyLcd8dtL3HgU2vp+Y4T9RGTgUcYotZl2PgZHz2
	IArO/zOrPjvmK6O3YXX2jva3M1kC0Od0gyL6jISSOeac8ulle0vesODOo1LF/00PlfkVMRE7ZVZ
	9bopLjMld0MkU2PQR8seP70+mrukBxaymk4jXYmo/iwLrzYGbsZl6aKkLZBN/+92Uu8BLBFzci7
	lONr9iSU80liX99GuNkE/XbAZ73yupvLCJlAYlTCdFgGfjeNO2iHNVJD0jAu+1Ke0jv+UuGgpLf
	KkPNLwgcThXKsCGjOzPAGqI1Dt1p3oyoy3Kv89wW6XQF7sQs40nMVVjS0zox/pGLReLnfrsuJn5
	0q82OTw30W6y5eaRaXgdQ4SGWpEBmTTtJcXQDaSjX9Rv0E1OyRiLJ+pp3SPPF/TKjT+MNrW0H4K
	81eZV8DCMXlnQqJmK6GL+yRw1AxudRzm6HezArsE71udBOb745TvF9XRLCnS/5rO3+z4Zym6600
	a6RdRHbGzU9FM0H4ZmWdJKbhUwe0rEVvssazmBjvK6T7cXzZonlP7oKswnKMjfoMs9TZJNqVT4q
	WKBaL8P36Cl+vqWf99mTP0aQuH/zhEhAm923o5LXNyOBzQPFQw0NYSJpTAsLBKyqQw==
X-Received: by 2002:a05:6214:1c8d:b0:91e:9a99:ba23 with SMTP id 6a1803df08f44-91e9a99c112mr10523846d6.35.1793872852108;
        Thu, 05 Nov 2026 02:00:52 -0800 (PST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e9c4e656asm6919406d6.42.2026.11.05.02.00.51
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:51 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c79a9a739so23683726d6.1
        for <linux-modules@vger.kernel.org>; Thu, 05 Nov 2026 02:00:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBytwSg+xVbqC5Uy7HlTcSvNNOi/3p7xFNus87lh8h0WvHOZta/J5EBuK+2sgz6ImgGxaYrM5/sBKtX+hsCz@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
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
