Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=0epWXrz6ue4ZZykuG105F92XEbmz1dM4vn/2fcsDdgmt8oRKR6pqsKNybOdr5cl91mcu
	 9kvt8g5OJsHiy5bwJvwJSYm+6JPtNW5sYxVIHjiybN/hjWOAcuLFuRElHlTgp62zsU7Eh
	 JnslIS9U4crkZaywTxrvBTn/k+lMnczGSuqaYmS3RmZrGkIFEnTGYEC22Cut3JS9649B5
	 sAtRdo/a7d2DGUBJwymxlJmPMqp1NNbdNKK+Z7wKJPAYEQr4pLg0BtmnGoCtXkQqEyzsX
	 okdVRqf1zTlJipa2nGJhc6E0nU/QfRbAMcXy+uEu7GZsE2UD4P1E4L/XutsHUXRuDsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=lqRn83eE/gbZiof+BnOOBhYZYddeCCdrzxa+a14HAJOepUNh22GDHdnP6G3W6QRLwBF3
	 a8MVsEmGYAwKVsxAmicfSLHB2cmMAiVS6W1gfpZ7JkW9FCw4mkAOQ3IEdxNsf9gM0b399
	 VqQ8m9Y7ND7yKZDP79aJxbrNzgb0BbRfJ+Vqu42MsQLqqZakUT4K6e1dZUTJD6n6BZWdW
	 bMGoqpU5w/uymP5DcbCLD1MBm+fKhBn0OLTW/iH7DucGs7iFYhRUivJauwWUvZ5Oy5yNd
	 2+gApgtyW8TYcvva0o1DGIMvhJ+/hShj9lQVi8CSUrjJGD90l1LMRBwZzls7S7mytbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28914606A320
	for <linux-modules@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28914606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so1338285e9.3
        for <linux-modules@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=wgirL3t87TcWCfmG691znpZCLL5mJUqx+cMWtwOF9ZIF4VWIwCkaKcaa4mzUXsDz9p
         1JVcdOP/OHf60UyrWEYNMHIZTJBH//+OA4+IMq/PwmLclrothEgJTajC7zLdw4PxP3Mx
         Lx/m4R9GaPRg1JWUCubqeFdyOBRc+qcdw1NE/DyVaVtoiCAFuwFlVE/nYD6bCIhauY6A
         SMa+vmUqNVDbPM91dBkQQ0ZE8pJv/BOOOhBqTLD71apah9u4QR1ZKOciVsgw7gbgzouW
         H/iAKRXdqqlWlW0OjYSp1RQQ0pdzot6wTsE41UiQlZX3IJUY2YdRks/7LtlPzqj+e2Lr
         qxhg==
X-Forwarded-Encrypted: i=1; AL+hErFUEMGUYmq3UxdQfStogHSfhFjrvLTav+9hx4+QtyX58U7okOYSy5yxU2614QrCIzP9CgLL9TibPyr5W3Fn@vger.kernel.org
X-Gm-Message-State: APuU4Z/yQcALodyukMtYEw6QKhJAR8vTV4GCiipoZ9dWP7Zbo/AUhHyO
	VhHo905AyIQ/yNr/RgYMCLr9GWI0EmO5dYNaJJdf+2uLaQugL5Zt6QoR
X-Gm-Gg: AYBFou3ureDPhMbNm1FV8lx0r9bWa2FLZw4nzxsjuix9PFfARm/znzqMNL1V7+/VTf8
	BP2puQ+X7uesLcBcLqy6FWzrjmVWxuvA/JSjZqt4PZwXVm4iy4puU04+3U9JhNsMGPY6laKBQwS
	3jyUA5+lNAafgN4ymGEr7jyC8b/8u9uitFh6pA2672ttsn8IGcPDfaI6SUQqm779ptinfFPEca5
	ZSIvyh69dDSZVYMJS76PvXAzuBWO2iNZc+eX5pQdlLPOvsDVsXaUYNJzJXsWR0brJWIcpB5koN2
	A8gUNAawCC0lVow5zSoAm50dEA0YzlxH2sYG0Rdgcr9Nue3cAt5Ly6hj6+WwdHlBALBRTJDS/dr
	36nn+NkLUt+5xKBqDrJcF1l7MhMlClI6vGt6HuQIbJJ4wvIUkNWs3b3DCQU9BNVsWzu00hMAFJr
	wSYLDRs168+DKkyvCdeeAW5j156R875D0rfD2ZtDpkBtBgoexSRUC1YzAQcC4a9O67al2PP/2Vh
	56jZGSsW2Kmg2mF5EY75qRupQwe5cxOAmbS0wkFYXnDSHQipYKVSzCdBCCT7ZaCQkw//whhGnF/
	pP0wbnYeAxzegX5/Lmf2BXW90hHLS/DPbQ3HmmVZgwdCQIRgTdewV5xJ6HxxqNOr
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
