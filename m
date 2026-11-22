Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348936;
	b=jh/4hO2ygUrA6bIbvjL/bBKCmDJM328dZWST3XzXlM7GX+n36VgHf3ROzgUj4yrUQzB/
	 RB9MORCjT1FZKiGBNZyQbNY/V49+B64qCtzsycLfwKboktWh2mthqJiBtomphLgQFZ7zq
	 vreFXJdtmBOz2Hynu8rz72bjvdHieKu3gWYgXELLbngH1CQAJkeQWCLRynXqQVmEcBVGY
	 bs1KQYm21YJYRCcsGOX2WR4Kb9g1mAGtnoHYndVi599qvYNLPXT8LXin8W54iX/5jtR4N
	 5T1eXsWxZCqV0qczRe1tYx+kFx8seTGMaBgYTm2buuh39SU0xVQ1FF4h9YfbdId6DoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mnbTDI36WLghMGaT+HXY/CzkNS4R4z0S9ISRupt5aH0=;
	b=AI7l3pBSAd9peqzBEwDW3W2U6tYTXCk3SAEePe5U97xd5yVCSV546iUS2ftGydg5eFAa
	 nHZksPUE2uuXGynfaaGwI2AT8d42bBB9hyZU/3p+9/ZkNFvjSA5FiddBOGySKGSsVAjm4
	 0oU8nRmMiauiKWGBFU3XjzbQGdNNb9s4t+FvzLwt+bH2z3BYXun/EVEc+qIyq5KPdZPbK
	 9TWPH02xbtZ5sgAVGWuZEx9GRpKK5P/7CYNm7CiUi8qTKTS6lUxfibKcBiecnrK2UYcf7
	 PdVB5hrx5Z+JfkPUvJZB0yy2NFyL8FGRYlPSPNTtDZV2PevIfIyFTLqtwhDDfe+slvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnOpkNxN;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DB606A331
	for <linux-modules@vger.kernel.org>; Sun, 22 Nov 2026 12:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37DB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnOpkNxN
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so19801725e9.0
        for <linux-modules@vger.kernel.org>; Sun, 22 Nov 2026 04:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348934; x=1795953734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mnbTDI36WLghMGaT+HXY/CzkNS4R4z0S9ISRupt5aH0=;
        b=PnOpkNxNDof9KYKwZQJxnSwAs2aa0+BlbghaZSdAaX0NpKtkUrzeKxKoLdFP6lUcp/
         AHsw2JRqRLMMwekZUZ7SkmZ56tJJ68q+/EsfIRG1Z0wWEp950hffo/Tn9Zqf7yZzqLg5
         rs3LDTyx3yswYxxQx64tAsJthNV8YnqxYhKJfyLmdMpQnI5PVjNXzSyE2u6kR9goWxgg
         oKySfBnD+C/CNB3AMVD6uHwbpdBarmwNKN6kIXIl1zAvQQDrg+zYs/rRI9eKyahHarZX
         ELIbAqumN2v+YTeXsmmmeYOfCH0c3Fa8hoFEwRkVFDmz0BW/6Z+S0wN76KZtwP40JuTL
         dDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348934; x=1795953734;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnbTDI36WLghMGaT+HXY/CzkNS4R4z0S9ISRupt5aH0=;
        b=fLS1b9YBrT+MD80/btxWeAoK0Ppem1+/+mIVysJLVAzm1+XRE3n/Xfdig3kGM1mzhP
         QDPFhDmeCKvnTOFco04AX9Nq9rJNmZil8YEJ/+Kmf5WQjIeluR/xZr8ZDzIwOhepj+WI
         WhVmch/XX5kMM7AUexbSmc7RDrwrL1VSMvE+4DxLCTiI2M3OC18YPVU8ggglZsI4xF6k
         wOL1xqlOkXMCSQKnqAsegcs/oteGpRQmlXv7+qfyEGTVCnjJz2NK3nNUYu50KNClVWh4
         4KQIsf51+CFIT0dvxRTwSObQtflqHNSg9sZsOdRgWGPLTNDBhd30ixzQpzvou8bErrDA
         KlRw==
X-Forwarded-Encrypted: i=1; AL+hErGT2mCmTio8AQ6FCEYGKv/glhNFLXwHGXzFSgjoS5fTjijL5oUmrdeImKKs8MFoYtVTMqcthB2ct7lNzpQY@vger.kernel.org
X-Gm-Message-State: APuU4Z9MVSaKTyCs0Ey2vAQWCD7VR+44c5RYexXWkGnxrDKJIqZVdVPH
	6GVTe8O5+6qN8SfDbcUFNUtd8yTEqKVoZjTywg3JfR1Y9sOEZzEn0HZ0
X-Gm-Gg: AZFdTZcjm0bC0Z9D5ZRvjLfh06CKtD2Lv6iMeyyvwSesuedxMx1lF7sNjtgRLAmgdYo
	lLjiFOc7du5JWH+7HFuW5vsGUkMW+tWFEr5nGJ6KaovTGWFLvsyvMOt7gWXV5bLjbBH+rAig9b9
	nxokfgwzwh8taJuiAFAcotyBUy0mlfHvvoVL4Xuvh7M6jVzoNjS5mkYDDebOwivZ/mq75J+Y2hL
	2oxXBKf6dwghFh4WgoGIXwsSnSCtG3nCeXyYbvOfVf7CPETEnTJjSNG/uoWVSepoP8FQvOKe3LF
	fJHkhfNtJ7gquypeWS3ia2Ceh43hL2N3CbaeE/BKyqY10SKlXP+/Wn/l1BJ2H+poz/Fsl6+lOx0
	lDhh7y4M3gGs4mlVGCBiKWanWDpYuzTNfINQOJxNFWVOEEUtvxWJoHPD8eI9jA7ZolpAM0hRx/T
	i2w31GzTnYT9vzn7UpXK1bbLmRrPsepDmATiCjFOOuxwvuVN30Q2QlzcqTFYu8e+CjStqUA7JTB
	JSGldjqd01D0EKEQhiOItE/w6Wrj5nysmAKkaYTkr2A3R6wkFNt51B4E7k1KLjqEHoQX4SGsKpG
	+u4lthwcRJxlsQyBW2prSjvhkuXNImHftNjdMTBlPsWvmsN/6QD57wGj/qcXWe2LFQ==
X-Received: by 2002:a05:600c:1d8c:b0:4bb:5345:606b with SMTP id 5b1f17b1804b1-4bb8882358dmr176469865e9.31.1795348934167;
        Sun, 22 Nov 2026 04:02:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066e34esm120387095e9.3.2026.11.22.04.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:02:13 -0800 (PST)
Date: Sun, 22 Nov 2026 12:02:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Cc: jim.cromie@gmail.com, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Andrew
 Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, Louis Chauvet
 <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 0/6] dyndbg,vmlinux.lds.h: fix i386 section alignment in
 BOUNDED_SECTION macros
Message-ID: <20261122120212.0dda7532@pumpkin>
In-Reply-To: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
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

On Sat, 21 Nov 2026 15:49:18 -0700
Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:

> This series fixes a latent i386 section-alignment bug, by adding
> explicit alignments into the BOUNDED_SECTION_* linker script macros.
> The misalignment appears once __dyndbg_classes is split in 2, and the
> 1st section has just 1 entry; the 2nd section implicitly gets ALIGN(4).

Would everything work if all these sections got an ALIGN(8)?
It would simplify everything and only cost a few bytes of memory
that no one is really going to notice.

(Apart from BTF which seems to be page aligned.)

David

> 
> 1. Refactor BOUNDED_SECTION_* (and HEADERED_SECTION_*) macros from
>    vmlinux.lds.h into include/asm-generic/bounded_sections.lds.h for
>    reuse.
> 
> 2. Drop the unused HEADERED_SECTION* macros from bounded_sections.lds.h.
> 
> 3. Add explicit ALIGN(8) defaults to BOUNDED_SECTION_* (with _ALIGNED
>    variants for non-8-byte tables like ORC_UNWIND_TABLE,
>    EXCEPTION_TABLE, TRACEDATA, INIT_SETUP, and NOTES), fixing an i386
>    NULL deref in dynamic_debug_init() caused by 28-byte
>    __dyndbg_classes misaligning the following __dyndbg section.
> 
> 4. Remove now-redundant outer `. = ALIGN(8);` directives preceding 
>    BOUNDED_SECTION* uses in vmlinux.lds.h.
> 
> 5. Add include/asm-generic/dyndbg.lds.h with DYNDBG_SECTIONS() for 
>    vmlinux.lds.h and MOD_DYNDBG_SECTIONS() (`0 : ALIGN(8)` + `KEEP`) for
>    scripts/module.lds.S, fixing lost __dyndbg* sections in DRM modules 
>    under CONFIG_DRM_USE_DYNAMIC_DEBUG=y.
> 
> 6. fix checkpatch to skip macro-rules checks on any *.lds.h, in 3
>    places where only vmlinux.lds.h is currently skipped.
> 
> NB: most of this patchset was split out of larger series fixing
> dyndbg-classmaps.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> Jim Cromie (6):
>       vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
>       vmlinux.lds.h: drop unused HEADERED_SECTION* macros
>       vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
>       vmlinux.lds.h: remove redundant ALIGN(8) directives
>       dyndbg.lds.S: fix lost dyndbg sections in modules
>       checkpatch.pl: generalize linker script macro exceptions
> 
>  MAINTAINERS                                |  1 +
>  include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++
>  include/asm-generic/dyndbg.lds.h           | 18 ++++++++
>  include/asm-generic/vmlinux.lds.h          | 68 ++++++------------------------
>  scripts/checkpatch.pl                      |  6 +--
>  scripts/module.lds.S                       |  2 +
>  6 files changed, 69 insertions(+), 58 deletions(-)
> ---
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> change-id: 20261121-vmlinux-lds-b59410146885
> 
> Best regards,

