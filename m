Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642758;
	b=lnDSaIWvlnE/jEOGmPj148zdb48ZdZcFaTvxhLZYtTx3+NZ3mpVyfBdrtf3/xPYt8mw3
	 /S28TRLRyY9x/t9wujmuP21I30AaYPtRKyIsg4y0JpYQ/pGNWCaPNWKZb6ZhPXAtvE27k
	 G+58Z4O2B9Bzu/1N9YhizH9E6oTRtqK3hx2scqDkeb+5Qm1RYkX1nr22Yx/hjb9bEhbxa
	 7damUnBnThneQhe4Qe1bkYDgRu4rOx7Z6BbvTCyP8rZ5MCKUf3dgoDtQm/KePVNseloHi
	 jJC4CJJGEAdrnCMnc9DEY7b9vxAcuUHWKsggkvFljAK3WAL8iO2GSxyWkW20f8LZhSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=e8SPC/DW00V0yoNrEjijmzgdrYTBC4tICPEtzGCvBA1o4yi7juUBsQriIcAqCJKYrASg
	 9e8iIxnOkdh6/bGBL5qQl+5WKwgynZm5luTQOqcxOsXE8ex2u+i4iYGF161gF0o1rS5sq
	 YNwJUUFG53m6zPAgCENQiFSgmk5gP/aBidWhjXMe9q1LO1cZKtG73tyN0ABYD3dKDAOdV
	 fWjGas11hZoORnY+rlBXrnN2Vi5JUKmYTk8/hZuMERwic9UH07vmAMcC9cjZn7IzFEiCR
	 EoCQHCPrln/0nh1eEwzTLuHp9sW5WBK1/J4ZAENC8hkYsPK6HVuBC2mkHdklaNWp6Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eT2z6k8a;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6B606A339
	for <linux-modules@vger.kernel.org>; Mon,  2 Nov 2026 18:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E6B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eT2z6k8a
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab35e31f6dso36121251fa.1
        for <linux-modules@vger.kernel.org>; Mon, 02 Nov 2026 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642756; x=1794247556; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=eT2z6k8a2ShSqTc1AvA15+80+g/OshSdSYXwCUgNcf5NUEc58G91KLxLBAAJtUvnph
         F0z+k8L+Mb83tMj8buKQOSUmvmFfpRsSugabwmQCuyGZSe2zRl2j2sgg25snkOzx/VC0
         KxEHfAJVGWJ2X3oLFB7TjcsxdYcCPVieLFJPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642756; x=1794247556;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=AZZ9Z2KMtt6jVK9JnH4qb8jOTMWsCufuMSkKPN1Y+vxPOlS6esEUpCDGPCT8mqQQey
         LHkaPZLjkWHzqfID4jY0tpOXqHj8CPP6xNWB8OeOqUvLATcQq+KDOR6Zmnn+By/mITGT
         IC9rCGTPfFgHn3/g+jl036xEvqym2aWKw3FtvnOym2Mysddd6dQ6vkFh56JrAqaUJlVa
         F4hxzwe89kRnVTcOI0k5TvgP1pbsUnxjyvalMaZQMKZCupbEhhSWID/Cunmo2h13yctd
         3ryndFiZzyvqu2tPAIrYHarCBtgoonWWvdu6ssr4So+OQBE2mWX2IoK2kK18I6GyC+2G
         4wyg==
X-Forwarded-Encrypted: i=1; AKwUvBwOS1zpZjT0smEggzB89T9XfHpnUNAmy/6qgetxAC4kyFWZHPMBMzSF5WwXyBslP7RfWKdm7vUKVrMGgzPl@vger.kernel.org
X-Gm-Message-State: APuU4Z8r4kowB27Gz5+hlKSdyqiyX4pE77JtSQrhr6fg4k1gogAdLmdU
	anEORIfL123U3/Y2QPJH3JHkEwtSuz0bpEROKxS6gEnXPsjcbwROlsh2z4Soa8qI3+7m6a/HvRd
	yA74XnEdfjw==
X-Gm-Gg: AYBFou05eK1n8GcnwqtQfAzk0hlrsfPPL2k8kfUTeoc6646x2rIjqMFy56FxrCazwVy
	6Chxolq0tYm85+DwmaW92KAIgHDLncuo8Skq5gWSQ3DWjhpMqYjc5KBx0Q1MJWQl6+/NebAsL+q
	eBjz/TzjaNdYVkoIAcbSWrah2fJz0F408//6Rra15sytturDL3dJ/OG2bGqiLZEV/W5WQaSmgpC
	pRFG9WoghV5jjSgd+uFj3Y3RAJITwAn7SZtKbP6JswljylcOAK0CBdrxuqHkaYHKLJHchNkOY7d
	yF6vp5m7mbEPIhWYY9dnD0/mIEASe/f49eD8vQa9NkzIwHxVSPDWqRN0la653V46UhbX//rdiX3
	OaG/spzk5TPc6N8P/1Jy7kvpKpUvnoW8fDM9BAdzPcmm3NooXhWfGpeTToYkMVooH4bI/sO24zo
	3Y1QiLuhXAMejRotkCM5BCTpIMQr/G4J05V9d+Vh5yNUhMBjtd3rBa48wVoee4IxQn+92LjnUIJ
	yxGHYCp00N55CSa24aQJRRSvglmOQKpRWs5dUTHzM5jYo5CpTPgOqE5ri6aJhmkI5y7gp62nkHN
	To7KBIX7cqLvX7Sd3MCRslNGIk1JRPOrnEp/HVDW8Ubc/HInlzwbB4S0fbijAF1qCkUDLo+PKPw
	In8cl76t9ephrSgQTzgOiRIzh51w=
X-Received: by 2002:a05:6512:6689:20b0:5bf:d1e5:ea5 with SMTP id 2adb3069b0e04-5bfd1e510admr2230376e87.8.1793642755993;
        Mon, 02 Nov 2026 10:05:55 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07541b4sm1744975e87.81.2026.11.02.10.05.55
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:05:55 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so35847041fa.0
        for <linux-modules@vger.kernel.org>; Mon, 02 Nov 2026 10:05:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxRGzM3FNS+yXruttCuf8WyLLnYRZE5qLVwYGDa8EgWSWvZ+xcW+Bw7kdQv9qGwIJkbwkTPpQHKTeB0eez4@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
