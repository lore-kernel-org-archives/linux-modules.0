Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273721;
	b=0di2GgG2QNEv/ED0xMzgujLn6Oodm9cG3gCVtpjHnLLny0/NBCl/7TwAXqjKhpge2Nti
	 rjfRWoIj7ioZrVARb9qXmF5Ckxt0a80bE7BCCxF28bNTGqzhz4UbJ7u7HsoCYN19XR86d
	 a5A8a9ElEyUZOfxPv5G/o6/mKIPmGcJEYnFGL7FvgoD5QQ+cZSimb1MGpw4KNztjbtpo0
	 dtvJe0+PRpJX65xL7wwRHBTDh129/gzHgs2W6Kc8EURSMT0RgNGdNUwYgMSME34d+bYcK
	 +dSdBsfDntdzOEzJ44OkCNvdAYDtQWU93Mnaop2ul9iIt6hbv8Stk7aYdXT+g0TGsag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=zSBEx5lKjbRSMxTSkyPVlhevNZ30Ky4vSt96GqaFJDr9fZmgvfbGEhLxNLrslhYzDc7t
	 809ZdFA2ANWjbT4mcUxMqitiA/4h1RgjUnJMFEKvAsQxoLVzlxKcVTWQTFWSGc68reQTt
	 HlKDJ41GUEhCfN7GEDjITExTlgK+q4ASJGZ7BjvJpyTRwncykKzJfTQeznG1Tj1SUFdA6
	 Ty3wrmxmzQzc3R1yz5+XDOy5dhTFQWi6T7vsnCrO7bAWC8+ConMd4akxgn/SLnTm1Z8gs
	 4v9mx3COGVDnh7oWzRIbqJ9OTeiNBmEf7hnhSNpxZ90UFHKhSGunz3c5GtmpeYib/fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TBFrmlHY;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13660A260E
	for <linux-modules@vger.kernel.org>; Tue, 10 Nov 2026 01:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C13660A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TBFrmlHY
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4cdc606b47so217291766b.0
        for <linux-modules@vger.kernel.org>; Mon, 09 Nov 2026 17:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273720; x=1794878520; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=TBFrmlHYwDfLU0AJVqyZJ5RjobSslpX5tFH8G+rYdIWboovRjdXRQO8ix9uhYwMtOw
         CDZtAg51Ubu+eSowuvYRDsdx3hyWrZbYsjvVlx7zcCRvEFo2AjdOrKSLMYxQJTlqFSy5
         TLuAQD1Xqc9hKShW2943/wm2lErNTVd6E8PjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273720; x=1794878520;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=DRbRzxkB1sBkqdw0/mvvxldmpcrlolKJbkCscsRaZEzcPHAhka7X17IKTk00IhBrlT
         RBpXvMsbA7sSV4q5bZerqcuorI+D47R50Aj8Enq0TXeGQrKJmQxUSbyo0Zn138WkCgcs
         463OHYOzNFOi2OCvmeKSr+OJKeyncFJNoyR87HQNcLvqdv1FLQhWQNT9IMKSNcfybAE7
         J/mRXhmOeXLwLnBsb9BKWFlGmIxg7iJzPDiqsMb98w8MXKe+9IMlo+Vquc4iU/qzLUEX
         mjd+emmKhMOvsW/gdY1le6/f90jTnwFrLmAR2d5Oqb3hXSe4udnragWJQ6V1MpwrOIog
         ZE/w==
X-Forwarded-Encrypted: i=1; AL+hErEpZbXxqZkU64HcatgxaW0S9tj/QNQBUwgpC7X14uX6IeoqarrLZpI9MnXXx8py4OMFcblGGDaz0aniQar+@vger.kernel.org
X-Gm-Message-State: APuU4Z/0gVWZt0+UESuRaped2fMGabTGsBqNHvynrZDcon0sSQgaIx8c
	m7mkPojx3FxQStnXX1eddneC9CaLeJ+2jXHTOzzYWeRZX8tiFdhviZ1cgjqL88khRnP0Bx14Xq0
	rofnwDprW1A==
X-Gm-Gg: AYBFou3DDWIPKUuwDqWn7xrERdlZtMkKh8maRMflmmi1/LbcQT2To2TdnXXcYyuiCme
	KALknEEEF8JsTJkZ+88fUAWKfayNpIHBOCGVS/V90DMFLBZ2VvqV4TpYczg6ZsGW6XKgx1DnQ5n
	/tywZOiiG4efvLCQS/dxNd/ivcwqnqkjJpNNnKPMdQ742J9BxOMYHXEeFG2C/f6ivktCs46/DEA
	nbGCWJimY4fyNRd5xTUaKa/Muks/Uuyh88azrZ0R4N1UJyM+x26kc/9U0ynf3qgvopChZnUvoKJ
	OdhjU/miRjEOc2M8ytqJZ9oVFGVolklJKk0Nr6aotOcuCAFW8j2vVhcdPCjFv9TwxVl/YUQAOXA
	5NirWu3Vu1VSCRIlVfUzVOHLNdcf/Iv3UpV7ef4Mfa6pSAgQoX7ZLvgjkNoOTJa0vyjEiUukx+/
	7vKDDKHfqoOfOCk8ZU5bAO9mc7zjBPrsLVg3p6I8a7E6WikoI1GTYNw40/dHNr2cQsHY+EjoLI/
	9slrr7IQgoLgn3jcDNGYUTEdnPOnz+doHo0gUX4EGRgwQm6QzK8FZ7+FUHrHQtJcAXVrxCMM95m
	P11RMCjOQdZswROPQCqul52KQxmSBfdu+Fle+Gm/lHHRpbm5urQJUYkkudiCatfrEW3G8N16GSd
	+hA==
X-Received: by 2002:a17:907:d06:b0:c25:2688:8212 with SMTP id a640c23a62f3a-c5048c75187mr85210066b.0.1794273719678;
        Mon, 09 Nov 2026 17:21:59 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a621csm42547666b.12.2026.11.09.17.21.59
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:21:59 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so242410966b.2
        for <linux-modules@vger.kernel.org>; Mon, 09 Nov 2026 17:21:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHQcQsxx3S6sEKVhYdRcAWtzsApv//04yZFyeNbr7zBWOfkYPILOjgm90dW/kwHjD7bEEwSjt2RQ43lKCC8@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
