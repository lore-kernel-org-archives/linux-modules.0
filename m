Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792672951;
	b=RBtalbipjzSkgBTD+oM1fXXzwLm++w2Ubt5199hHxGX1JAh04ObpHMyxNgc9lXM28PED
	 stUzDTSKQE5oyVseGh9mjpDPxNEDV+PT2B9agXIaPZ2DZWUktrex0CuzCL1D8b0/vphAl
	 ypxWaIZfGS3pMdNyztVaK2/GTEKU/i2/PBtNqFtLOE8T8mQ6fVnPKHgZmtUY4NtLSm327
	 P1bpsk0o3A/+KrhpqeMZf6zGhGCkH3K7Fin8NaOeXty0js8LN4BwtgW7/epqNmijBLIRX
	 wWr6eDBI2aGqTGjFqE+B4BPSksPeIMTpgRwEFRlyvMK4a/pFRw+IDNERfXmYOv2qzsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yahNT0bNvxOBrbmk+CPvWSF27fEnpvOdoj99aF3G+Zc=;
	b=Gd8KSH/vO+n2R2X5V+aBQ398NvU0vhG+OnNOcWlfFIf07ZB0BNdjEW0+lEnQy366Ujdy
	 G/i41fwvnbOY99aMHmL47eZ8wqfmsR9YJLwTfWVAg0KvRBlEzlALdDWssYkcntgCONkyr
	 PoS3X4HsN7V+7IGVJLBwINKe4wLhp6cz8CtdZLWgwJl1+x8NCmmuu7t54/6qepUkrIACA
	 FsXNdbxw0sB8XFuf9wOVKv7tqq7Otwy6+bNr2Bf2yR8+taNnNeAuipHrD+snLXirxmmMe
	 yXd6PvirkZwS1yWZIV0Btxm8zwPxS50gGwb0kwR8/vCGtlrw10u/qDSL850gRLSq3NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kar541c8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D4606A31A
	for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 12:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 321D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kar541c8
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-34c522572bfso195617eec.3
        for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 05:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792672950; cv=none;
        d=google.com; s=arc-20260327;
        b=GEyxdFozI0+2k70bY7dX9xtpFu13nIizrgEOKUEnOGDtlTR0FEgIIXJ7Xogdog0smp
         j1TTqED0XFz48jKqBIb5yIyq63QBoCmUAePOL9nXJJWDLMIc6tJ2+2W7kW8PJoV0eeWW
         g1/bcOvuqCsBB683o5TiUd8+XmQOAZLhmH2k0Q86AZnis71BPYCdMusEByji6/sQIwA3
         iyHuUyuYN00Uy2ys9cAsJTPQm2MRZ/5er0IQNZprWq0onmBz0vwjgSSpfZph1vwe1kzt
         dg7l4cZeuTuIXTGxsJe52fZgxpaTHnfBZRO1Q4oCX1aBZrb9tVnMxwWj3jofFy4XKohU
         O2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yahNT0bNvxOBrbmk+CPvWSF27fEnpvOdoj99aF3G+Zc=;
        fh=AB6x5AziKBlhpDjbfHOXDcsCIpHB5jDVUqLbNqn0adw=;
        b=TNCmq5insx5+8pyt8slo1NlcpaLQDpgY2VFvmKkbeT/62IJIGZ6lnAA5efaw3uKYs0
         mNqASpc20WvBvXozZOgwNOQn/jUU9dhj0ORgGoG1tmi/QKc/tZSt5bjUUvuAGln3tvYr
         ZWD+vFJLBgP4htlaD70C9etOszxLumtnzSxJsf3zhu1/YBEHSE4uphZDTXYcF9mxVmik
         jZ4xh7NZrn08YR8Ga+kA98bTWTJtbdSiyIATx3SZ90mODkl6+DsS8k2t07uTwy1Ux2e2
         ESMK19jY+7xf35j0Q9wn5KURGQc9MzrHom5q+x3ajTQe0bQFmBxntlEkCfrQ5+y6XX03
         Dtiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792672950; x=1793277750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yahNT0bNvxOBrbmk+CPvWSF27fEnpvOdoj99aF3G+Zc=;
        b=Kar541c8ClARwAoaapGMtGG3WzxlDV7TcahPyXsp6XpREWBZjLmOW0slbwmmW7fdKo
         HC/IaieL1B5xzjjryH7O+iAAUqFxTPw2LPOObNPTZ1HN5ketBkqWd0ifBmzxrfHfvvI/
         qPF99sbE3qNqBrLYTzGa/lBN9dRlMLGqJz2rN15qqZqCwPBUm3pcLiVgRZbUFVVbY2H+
         y9g21m+P/Tli0+nqmzVHzbzkxiYQQD74jFOl9nIlCpc4EpN0swIRfpiRq7HtLLdT1VgZ
         QhsuXlD7nAJBI8+z8gWWyrpAmjZsoIvdtzJb5Leb1Xq/oxbNkCEnmoHwY6yyTx8iOBbo
         i3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672950; x=1793277750;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yahNT0bNvxOBrbmk+CPvWSF27fEnpvOdoj99aF3G+Zc=;
        b=CZiuxxRMrAsjnvKENdiZWCd3+lvcCo4XsqhfcaDdDB9JH7f5opifZNdozuUD20Kram
         g6GQ7e5LUbtLLgp4B/5kqY4BGp8i3hd3Cx129Noe+VkdqueT4QvjvlFQ3voK5rYXdZcS
         O+Pjf7bXY37OitjaPkD34X0kowoZb3HQ1a8cDpWOZE5DA6gRke6NguLSH6B/RIIYno8S
         f87zOp/9zNU4V1bErgc46pI1vsIQbFZtGOlGLcMG8njzbnt/dXNqrN9yGB8PuBBV7zUi
         4irqod5h71Oj8xNtM2xYoqOE2poAqJeYn8m7YIE5wLqwdonD8xuUygA+gb2o8caVm0Tb
         0ISw==
X-Forwarded-Encrypted: i=1; AKwUvBxLUYUi2Z3sJ5Aq8BZ5OKgPudUe5J28Flfm9fHMz3xSjU9ywx/S24fmQ5hPV1k1TBBt9J9qBi14+owsZLZP@vger.kernel.org
X-Gm-Message-State: AFq9FYJaB1Sc8+wU7AATEr3mmVA0tkByii22A1jDJiPb/+mTGyPM1PbK
	dF4mjRohVxMyTFMGs0G1JWZLqsP9K8BptbZhf7t2D+QJ6pM9pPX88jmW2C2qivw/FAjKRJMZowM
	IW+FB4M+7TxN5SKnMWUgW7PJAc+MIUZg=
X-Gm-Gg: AYBFou0mlicwrSgT64r9JRNR2dPHxjCL/M2ILNmxl5kTlCPD+rcw6shCTE5/LZmvbiy
	uD+bJNXP4qQOPTztaUnRdC+GD5RlJ1kZ6y8DLPt0ivAnsc2t4XvodxJCmPb0+fV4I915Bh+O+vf
	bI2G8rn3yZcuV1pKelY3BOOLZMi9ibQRe2MaeW7Rh+9AJU32XgZB+scWhn+eHX1R40LB0Gr+NUQ
	UKQFNhmtdZjiNzx5XoLaYlSnib9VfwtNWNgEjgU/W2tg9x6/bNORlwqEBgHXGJxVLxlFL2lT1Jq
	I3Jt6PYGBXScwmmaYvB6A/8nY7fyF0IjAG7poHGLWurn/GVpoklMQ3+jaB+1lS/Zm4+wc/nsLef
	GfvEvcF4ANEdKDWwPs3md9+VOIqIZuCQogdoM2p9crhrep6l3MMAZxTfyH+PKgc/N/FhiAZZdc9
	NJW8z2bnpqNfqQPpQaIi3xRpcyqrJPlW7WtQksDquywve/i0FfXWvdhtUXoKw+37nMTGRgnd1Hi
	6jq9sRcxD7CiUSueRSrLQyRUToAMTp7/n8kVsB4zjfXmRNBGX1teIEuYA==
X-Received: by 2002:a05:7022:f519:b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1909acc857bmr8644920c88.0.1792672950050; Thu, 22 Oct 2026
 05:42:30 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019151243.1595858-1-gprocida@google.com> <CANiq72nqq4oGBWVtSMBhXS6G4H7fYg07ysD7SjnOWWt7R9_ajw@mail.gmail.com>
 <CAGvU0HnBuoVMf2JwEhRCijxRn9MPnrX=yxxbo3YywT+RqCTheg@mail.gmail.com>
In-Reply-To: <CAGvU0HnBuoVMf2JwEhRCijxRn9MPnrX=yxxbo3YywT+RqCTheg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 Oct 2026 14:42:15 +0200
X-Gm-Features: AclHuK_T88Zy9oQREVqC19uHWElftZvOLaKoRRSb6QAdFImUnbbltGYd7908h9M
Message-ID: <CANiq72mN9JYVitqgsZ2GkdmPVWqHZpJ-WNMNviiHV6C7gQMUwA@mail.gmail.com>
Subject: Re: [PATCH] rust: exports: emit ___EXPORT_SYMBOL without C declarations
To: Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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

On Wed, Oct 21, 2026 at 4:21=E2=80=AFPM Giuliano Procida <gprocida@google.c=
om> wrote:
>
> The description was AI generated, but it is accurate. Both paths use the
> triple-underscore three-argument macro alone.

Yeah, I understand that not having the `extern` and so on is what the
AI wants to emphasize here, instead of the `asm(...` wrapping of the
`#else` side, but it sounds confusing to me, i.e. it introduces the
change as if matching the assembly path was important for some reason
in particular.

> I wondered the same thing, but that would introduce yet another intermedi=
ate
> macro.

We are introducing a macro either way -- in fact we have to introduce
it twice if we don't do it centrally.

I guess you mean avoiding the duplication in the C header, but that
duplication already exists in this version. So if no new intermediate
macro is preferred, then at least the duplication would be more local
and thus more obvious when they both need to be updated.

> No, Android kernels have been built with Clang for years.
>
> We post-process DWARF information with STG for ABI purposes and noticed
> this interesting side effect there.

Ah, nevermind, I checked the DWARF emitted by Clang, but without
gendwarfksyms, my bad (I am aware of Android using Clang, of course;
it is why it sounded strange and wanted to double-check if it was
related to GCC somehow).

Thanks!

Cheers,
Miguel
