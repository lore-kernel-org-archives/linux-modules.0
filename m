Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872957;
	b=l5A+t0FP17zLHhVnBZOoLYSmB4EXHCy5914dMiV2jAggokZmW/JThhTd0Axg4Zr0XZHy
	 2FxhLayZjzqAE/duXhJzqibwEqeN7uVYqh0asCck1280t3PsufnFsLkEj67R6b2x3xUHE
	 O6tVRtFSR3S+fz6mbE/1KYHhatAdioKG5LaW/wRtIeg+jspHZqdFepQ8edurGDbkbnorf
	 ZcpDp6REFvRCERV7/CRZ07UOkFTSRt575kYHTls60D9PCGWf2xfPen/lcIEldyJvDCL5W
	 MjIAXMPn2iVu5D44osQWLellpVA56Vtb8SoH8IJhB1GMAkrnoe0hpWAxtQWqa8VcIbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872957;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	b=LrIUHJCvfqOkW6nC/2NGrRu/3IYbs63Cj9YBTsYSrIBNRrcIptMOfGYeeQolhXzoSgni
	 lFhtjUHPep1R7srMfhq5i7Ul+ZceME9yHGJ+1i1gZghHw91acl6g1cFHOgtUHR3beHcWl
	 S6Eq7aIZGRs1VvQVcU/Wf4jch9lVYh3Wb1m1Mnznuk2h/4YsAFvrBu5py7Vrv458R6oIs
	 naEcaJjz3vQfxrGe/2Jdv71bbvu3i72tz6UHqPf7bDEWxkRo1gEhB8CayYsQF7jXDtAb4
	 /PLAezxuLGk2FxlI/AGwCX+4Nl9u/yBzKMXFp0OfVdViOqv6YlIdHT7Zda/W0OnnnbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072E606A31B
	for <linux-modules@vger.kernel.org>; Thu,  5 Nov 2026 10:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9072E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5365d26ccbdso19510161cf.0
        for <linux-modules@vger.kernel.org>; Thu, 05 Nov 2026 02:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872956; x=1794477756;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=v+jzKLJl+RnbzUV8lOt7NXpCs5C3hIznAm6/ygpd4n5tYRnbDCrBkMEevg/Jj72twC
         qyq42scaA7Py78xHB8Do37kKY2sV/XMMyEwZXJonj1B4lfFW9Oq93+2IkDHmIfGfJIYH
         SToI6rNW/4/y/g7rUEfFW52vDWrrjmXILcibBWM4SE9AweQS0+wW6UtzW2wHuo5zJK0G
         fKtVvrPWoRTbtwQ/wLBzRmf6z9npjlrTj6zyueee/flv759e4M7MAGRxZtpgWrtTCW2x
         auRTDmGlWg6K4dlKqRDZPj1ze17wfOwFoGR9sMQTrYtRB1tUE6avbdwFNQvsNwP+ZAnV
         1tCA==
X-Forwarded-Encrypted: i=1; AKwUvBzXgw9suw5vB5CjOH+1r/bmFRcjz7u+bBtQyipyBzYNJr6i71F7rTBnFNanOkgRFe4iOYRtNS5/wPZCOGOL@vger.kernel.org
X-Gm-Message-State: APuU4Z+MTpsAdn9tViokjx7jDSyfsYj3HzcOMKp+buvOpN+d+qzZOsV6
	I/zMON/+ZrNuY4PRDm6M9ilMc0xOhtGQt7mrmx9zosqTzy4ElHRtu0PQPTup1MkMSrY=
X-Gm-Gg: AYBFou0E3/6DiuViyG83jxcu/mZ+fbXZ15T87d4cLtim9Laflr0HF7UdvaKosxYDUGX
	gRUN075+sdgzkg8ViyAJEntWqldB1uhs7Lgs3TXedXvjHB0MkigreEm2R4aX8ZJpv8lO2ZEmQsU
	OWcfNGu35kBLSdy34M+oNNALNdfx8ThsyRgiZWy+yEA5BlxPNs2YQBPMbotg8gZzir8Avq2dfku
	lE6K/iVNkrgUGxa2QvCk0Km6QaSgrpeC18ERpne5jYwcpqwNXMgFrQCX3Nga6MefKTPnF1lYqW+
	n/pGvdW9XExUpK6UTTUVEl6E9FZe2h+7NdT718nNASwirpivfeKtyJixG0Bs4998DlWDSuu3UOR
	qdhilN37Y7skYYsVqjX2xD8nCuhmj5ordfkkbDdp1UeQ3UGyTLn0FY0FORlSZNpFRVk+kBvFze0
	AnyoI8lk0NAIP4ZtHjcg4tuzhs93TDjM6Hw5wnbNroVeIk8BhizEZ0XIjamvMQCS/r9s2MzKcTc
	gs1XL9lx346rD93Yv+RDWB0MaKe2s3y7bBYwlvXIK+FdIS+5KNEC50MU8jO+HSM4YbTUuOStjMK
	NGFn2blz9vBmmRJX6Hwd3PaQBnkyo3EU9PvdBIvyrdcJBO1h1AwZjp7fzYUBxahuJPdzkQ==
X-Received: by 2002:a05:622a:1247:b0:533:983b:e53f with SMTP id d75a77b69052e-542b781d936mr283936491cf.59.1793872956597;
        Thu, 05 Nov 2026 02:02:36 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfdfb81sm43618086d6.19.2026.11.05.02.02.35
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:36 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f20c3aaa5so168661985a.2
        for <linux-modules@vger.kernel.org>; Thu, 05 Nov 2026 02:02:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBycOc4hOO+qoU3gTJZrVu00ERvoBgX0iQyqgpFwaUIyYetVdymfLUwHVRklSchEcPzbW/YH+21jUqFmVxDy@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
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
