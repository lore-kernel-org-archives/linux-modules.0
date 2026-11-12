Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493262;
	b=12vdkmm201uYd+X7nQJimkHg3V192VEnP5MzVj1t4Z3xUtLnLEYsEod9fz1c4hwof9g2
	 1ZltbiKneSc8cu3OshKxUzK7meE3dpoTINjNqugWbu33CuKYk89fP524suKac/KQ8eKpA
	 Kn4toq0nb6Dycx1TJl0+5HLbFCFJMBsCIIXdMau2FTahctpN+8r/7Qxw9Vnf+0i6bb0Vz
	 eRQdoYZ8BRFOBdg64A1/JCL7XLDzLWPk/BYLtPXhLz9ODacDjUGSds2psH+EKVrXfgpOx
	 b+hvtQr2PgfBS3DZOkg6btDAA7hYUkM/+W4ssnjWIaP/EQP0n0Bf4awkneU23TpjwIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OupxHyRM+umbW423wKXJxlldk10XI7UdvUQ9Y9tR3mM=;
	b=boU8hRCSGBIWXHmCIEfE6lpnZQGQpfD0YUdNcjIO6869F3ABrwU3cuw7GbTFFltNGAP2
	 g9ULunuNe9jftOqDH97FnFR6tIk3maLAVEFxpENVxfHWQvZRAzCQQuxJbqT75BsDCFpRc
	 wO7iFDDqqcRhj2voVsC/zNL6eMDKOqDujq29rWyIpbybZFlWsFyGVkR/E1Hw5YG8Tlc0D
	 H5tjN/1Ye2vtKcd3gMuPsH6Xvy1WfKiT8hZrKLguWwezXjNfqw8fXO70B1p/hRQAygFOk
	 NRNdZR0VuU0ES1k83DEXIcmzNmlUe9rYdpeB23Bu8JM4j4YZ/Z5K33KC0oPmiC2gZMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRM5RV3o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD1606A8BD
	for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 14:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EBD1606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRM5RV3o
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bb5afa736so214217eec.1
        for <linux-modules@vger.kernel.org>; Thu, 12 Nov 2026 06:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794493261; cv=none;
        d=google.com; s=arc-20260327;
        b=RqQlhcmVorAgib1hQ5C/mK5ObZfxc6c3smJE59LBBOGWOOxv/99fjy8fskNT5592Y9
         yCIgBbyk+3lGUBiwwY89iet2j+ad/8JlXk4TniMFewdR4Go1MunWJoAaCjHWcK9DXoPZ
         XO85Vc+iWhjBNMwlFK1hqJ9A4GKfPef2XyCVmntHnSy+81K1uYbsouLhET+tS0eCB8zY
         ub5MmkhBhPdfZlPpDklP1oftt89lZynBdISmzPREFDxh5Oz07iQ4BYP2TW8VqGvKP1AT
         fLEEgRta4l2xYMVroqfqL3ZF0Qt3xNo+AUG2CxhYAVnoPQ4e12Ci4JBnSFHfYM1DPubh
         +hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OupxHyRM+umbW423wKXJxlldk10XI7UdvUQ9Y9tR3mM=;
        fh=LU6iai85fy9IjneWTPq+jdomW6xp5H3qodaefEJrTNw=;
        b=YIHXrK7g5bQU/okSrBF66xrcKm+Ia0I58ipjAojLvqpPz5zXNtpdl7OOM3VbIgBgDj
         9myFiBo3kY2waRJPQLxoKlqUeol/d496wS6UKoVEppthDK4KXpi5ggVVHNGRGq4Z9tGC
         MBDYXneRfPS13l3FEbTKylLuNUzaxCPl27LXMCQpQnAzPCcb5Tz0C7Dqu5wwB/6W8vpD
         GV6rmq6aIXSSIZJo88Jn2392Hxy4Fdn+1Av1b9cqPV9TVsWqJkgiCZDY53QfJsenA6oz
         GZXGirKQsNV6bpp/NmxoMPmuSpMC9bEQ+a7f/GpEM4Rsb9evdCTwqAGLPshNBGJhRto1
         PLUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493261; x=1795098061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OupxHyRM+umbW423wKXJxlldk10XI7UdvUQ9Y9tR3mM=;
        b=RRM5RV3ojFftw6JfMgFPWgXIRbKkVxR0tRVDIzvlKunec9MNBbvAVocoEqhHyB3B/z
         ftOmhOdzJKWfq9jaPn8ZdUCn9WyLwYpmtMDxP7Nm7fVmOA+51Da/fgWbu1ZogdW4Qvj1
         L75YgkvafDPOq6DSGO5je4sjg74Yp4rbHNfmsB8hWdl3YiESJpY94KZ2NjYWKYvezAga
         eRXi4Fg0+vEa+qHmTXOFSvcO8nd1wf6dxPb60MzpqMipgF9zQOC48mdhAx18itjOK9n8
         YJHhYTrr2yDyqEt4vLSq/SLOULOv9pRTLgsJsi5kYqcC48tmmrMMfrdFu0ymwKQ1gKiW
         cbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493261; x=1795098061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OupxHyRM+umbW423wKXJxlldk10XI7UdvUQ9Y9tR3mM=;
        b=y920W6XvgYXPGgEaxGiPY8COzs44R5JYFzbHcPJhiwokMX9tsRrH2TmAkXx4HGrS5j
         EXxgtQ7UjJc0FKYhBqdtSk4Yx8u5hGvlxnw2E0rUu+9oYitWjqd5EwuFX8Y/RoaaNq9G
         4ZKYuzA8B8vc0uc2gTLldhZ2FWD6DgCzHpGXEF1puSZ48VxjicGywWmX6INBdrLucXRg
         nX4QONTZxOqhbNcD+Iq9sqi+GDjP5Fs0z/lPVb2MkbPp2GciE86yAfDLiszS6vbSXwRs
         o/PmTBje5/m4cWWS/L60CAYewI/N27YB8UB9Fd7H5VFG1AFlOb76k8Tf7xiivYVCmA98
         aC1Q==
X-Forwarded-Encrypted: i=1; AL+hErGwjOVKv5xsd8YtY8BQ9mrfsnvz5dgUf0v+Sy6XCqtic0Bf/AxlnkEfUq4ooPByVzuNaNpzS8STN1495VzC@vger.kernel.org
X-Gm-Message-State: APuU4Z8z7Br3ZOsKHuMhhdxqW/ReDocOuXYNKyBY8NN6Zyf6Tkb+3rlw
	dxV/BJG5JgKOyWL2XaO6AsHnQRF/ubjvfNR8S6abyFy/xr2dc1GiCdAD4sE+ZHEXsdyOO+V9YRk
	xda8cAE/MqE2UfO+BhpM2Alv1+VJvGyM=
X-Gm-Gg: AYBFou0CzcpcfzMiJgMv0lxKGX63dK8Ltn65YqC+hY3Z8ZfwCzPuL35FcMQQKBXH+zs
	IJOiqKvhPQaVORIn1Eg5O6KMBI9TRWbSZTqs9cNWtEXvcyg6Yo3Zag8RdbH3ugPNC4+yRLmn/zB
	7C8BjWTsE2djz9Dz/pXLsAo+uEEzOkV66PdpdSg3N/qm4XntrDTHkxSugaWoYrviG0LqIdiu9ut
	Jj/xejjy281W3WhmXM1fCGoDICCwBQaP07w4z/vs3oB+UF9BoyacU2CWwZW2xMP/zkWMHS38owL
	Cnjcv4KcLMqLo1gRSKDCN7lquwPbJyxzMF1eykyZ3hp4ObIVa8msXi307ywvqI20/SHUDYOnjt1
	PcZathjrLGP0YoF9xI1+r9e3szkNwuftVcNn6DOfIjWxgmUYDrtxetUkOci0QQ/7aOD3wrNqwEg
	LqYtWKGFb581LrayaawqqUfZAXh81z57JjJk0qLihIFdWWjboJktSaPU6aNA+iSjPHHw9yqtguo
	BZdXggUZR57TJEsk/iH0ki/0A+fS6gOqRm5o3tEx7UUNpjMjDbL/sidcdSMTNYkxdM/tJs=
X-Received: by 2002:a05:7300:7aa5:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-37685c76d17mr9166936eec.2.1794493260363; Thu, 12 Nov 2026
 06:21:00 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112121512.1670347-1-gprocida@google.com> <20261112121512.1670347-3-gprocida@google.com>
In-Reply-To: <20261112121512.1670347-3-gprocida@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Nov 2026 15:20:46 +0100
X-Gm-Features: AclHuK8Dsnej4GxSZdQmdf9s-8C89r0Ozx2FMVSaC8sIWGqdgayIjlPcXZdV2eI
Message-ID: <CANiq72knbS_-8ekPfMbaF9Z2V7=DSCLdbxECb4d8o-vv=CYJMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] rust: convert exports.c to assembly
To: Giuliano Procida <gprocida@google.com>, Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 1:15=E2=80=AFPM Giuliano Procida <gprocida@google.c=
om> wrote:
>
> Previously, `rust/exports.c` defined `EXPORT_SYMBOL_RUST_GPL(sym)` with
> `extern int sym;` so that it could invoke the C `EXPORT_SYMBOL_GPL(sym)`
> macro, which requires `sym` to be a declared C identifier in scope for
> `typeof(sym)`, `__ADDRESSABLE(sym)` and `__GENDWARFKSYMS_EXPORT(sym)`.
>
> This caused the C compiler to emit DWARF debug information in
> `rust/exports.o` describing every exported Rust and helper symbol,
> functions and data alike, as a C `int` variable. Those bogus `int` DWARF
> entries ended up in `vmlinux`, conflicting with the true DWARF types
> emitted by `rustc` and confusing debuggers and ABI analysis tools.
>
> Convert `rust/exports.c` to `rust/exports.S` and emit
> `EXPORT_SYMBOL_GPL(sym)` directly. Under `__ASSEMBLY__`,
> `<linux/export.h>` expands `EXPORT_SYMBOL_GPL(sym)` straight to
> `___EXPORT_SYMBOL(sym, "GPL", ...)` without requiring symbol
> declarations or emitting bogus DWARF entries, while also avoiding a C
> compilation step.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>

I guess Suggested-by: Gary?

Cheers,
Miguel
