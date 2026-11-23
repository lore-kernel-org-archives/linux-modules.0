Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440551;
	b=ieh++qP3+AB+tkKEWEDyTFqHASf4DiLQvWQuxpbpwXzQV7J1sivmgWlrfrbv3rnQJDSj
	 ZiNgvyPMOY3Vv+ilT4CIt53urJRG2l/7CuL3TY0VX3UEgM/fDJQj+X9e04HhrOLjQX6nK
	 mQQsMHOicdbgzmBBjbhwq3Fl4wudfJ8QNnkMKUnEQY6R+ji28zbPRMYm5UQo0xgD/mqRR
	 3HGUl22eqy1wM8eTFktUzPh8US24NKXEYk7vroljELdp6BHA09TM9GTLt8CetWxMvBf+p
	 zo5SytMS+v8I64ZfPC9c/0xOp+JPqhN2jtBVdC3XcBa/2x9RCjjWiSOJlvXh3Y5o/4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5P0SfAg0RNgf//T93vMcvwfndd3128+sOIInvKqWpbA=;
	b=VUvCGyKtte39YvbJ84uNXFq8N/VORJf156EEu0wg7j8DU5g9bOZRLoskSWyV61XTmsb8
	 nvwfeWFhihvsTr63PNGNbzBQvQ4y62SRWNakGnWUamDRe0bbm4edn0BYCVO0gzDqzLPd7
	 /hR+eoIUIKs7zh4kZf0wH0B9VDC9tqa+KyN2pwA4v0K2zWsrZ8ureu2WnfpI3/Hc+M9I8
	 Z7ykmEIyMTkuO49GVgtRrPWJdFBReHm4hHlcyFu1CRw0egOgkhkjGmTyAhm377V/roLiw
	 0HCF3NMJGfQWmTQ1JTXZQ2wqF0a1q8SjYh5jhHa0ktbvxwW6ZFlsLiYr1tzRRRskMFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U72tvcMy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A106606A31A
	for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 13:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A106606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U72tvcMy
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c0ace36e8eso233156e87.0
        for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 05:29:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795440550; cv=none;
        d=google.com; s=arc-20260327;
        b=gJjTV1uNsvvMRYmILsuZbll+h/AjZyD4S+qXsqUSaBMfAx4XYIHkBho25xbdD/bggJ
         sbsoU/PPEGfsLVUFG5YRa/OFrgn6NHOZBRRQuqpHxxwnOjoY1NMPVKiayLmzNBVIDYSu
         jIDqVNlNb69NSyP1ayipUMzOxkDuQXHnGNVbJttvrGD1spupy1BrH9D3yg9CymnMqIkR
         LzSMijemiLOJE5E0k14jSeWcQ38ual8RHkLP061x6Vaxj8X1ODYOrhxG4hCb8p1QKB4R
         4E8k8O8QGD17GF0Cs/wsfAPl2cR+PVdkA8OIagI5keEK0b6JnfRaJHJezcWVb/JlxQ0L
         kgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5P0SfAg0RNgf//T93vMcvwfndd3128+sOIInvKqWpbA=;
        fh=B6/UT9m4bmrtcFzx2+xMFbSQFSzaofxXFyPFf35AEdU=;
        b=LhhMlxPObN5a/QSZhvLIVzgWsjIRJYpFR+XlmB5UFNkvdIwd4PMPQ1Cdzw3UE5C3Kr
         5xTw0/DJuEB3Ys87VSdF2MZreoil8rlU5jrV80vlN2wWprWWMtpi49/OcJlX2W6cMc0r
         FCJGycZjYFuBCK7Ce6WqaW9xmwkWY28rwd6Ac7FHcHiFBC8kJHfQ4qPw7q07pUIWxqCl
         GHLC2+HqYKRyV82KzhMEAHj3Kezykfb46+2jK9mHVXtTSmWHAuwzpUBmf0U2gZZ5reAb
         kiwnoRZklL6pFQpOnHj+TOQyv1CKaNuP9nXd3T5t7CvdivyZ/PguMJrQHTi0q4ZrLwWN
         6u6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795440550; x=1796045350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5P0SfAg0RNgf//T93vMcvwfndd3128+sOIInvKqWpbA=;
        b=U72tvcMyV5XMhL9cZWj+pz06WurNiz2d005dmAPzrrXo6karRJl+VT0FOaBnD0G7wV
         ai9Z3lRkjFc3cL7DveVH4oLwS6Ya2AbR4zjbWXV0ySev18N+WySR8FRgj38zCV79zsyy
         0QgOAmP7d++U35Pp+P3xZmSLuwEo6a9+t5lY19X+k7rxKAKPk7Ab5Iqe5ka2iOkGnOza
         QfCW8GbQjbJqmNHdxS2QsECbA7IBX5C/n5LJDcWpuyDpj8YumNchG1QW9m1tEz4AMBLb
         xBbre5Xtd+L89N2pkXYlClp/sRqqcQ+RSpDiL4mozFN/hcCbiT0rGPX6ANhH10LFM0P2
         LVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440550; x=1796045350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5P0SfAg0RNgf//T93vMcvwfndd3128+sOIInvKqWpbA=;
        b=KVgnaRRvMtzrJRSE4BCdYaLKAGL7kdYrZfaHz1M06XbOWn+7/DOEwmq10/Buo/0OQL
         I0CV2XEcoiHV06sTx6Oa+hXjNBfULw9INUx+IP+2SuNGo7rZFuEgqdAREmbYq1ceqzGM
         TE4NGi6hi7fYf/VEAPS1M7RnlFkazQesGrzG2g+fMBV29Vj5j0Gdjz+nDlpFHoy+Cnhk
         Ajj6n17lErjeIwvGkzuUbSrpYeATcYl94WK+riI0/kPopW3Ux2QnhCj/FHEAgAM0JRPd
         +kGtIoIQicFxQAbPc9GDdVbzLFWjWkzM1dKE7bWUPoKHR6eA305i1DEC50HI6+pRd14X
         aQEA==
X-Forwarded-Encrypted: i=1; AL+hErHE6RziYK+8KQ+GRoSIj6BD8oCJq9+O093FA9+jAweHY2kJeUdCYJ+HuPEzcSyZFaHoOhqVJvbOP/64ejL0@vger.kernel.org
X-Gm-Message-State: APuU4Z9LDHKw+qbZU2O9/UzfUX4HRXETBjANyZ+dL8ID2z7QxkjPXw08
	M1YqSYK9YGpCS90I0hKyjvhZUe0fNxJxTpRmVXZcykq6lZ2Pvvt/Vy9fbE0aJR9mALyn5FUjNuY
	ytDxSRd9PVmP/eBO09ECfc1bh2hKD7uA=
X-Gm-Gg: AZFdTZfdRrXtWoJL1O4ZzN7adsevfWu9fZ/4/IGm8pUId2xW72TGF2xgkk3S7e+X0yM
	pezz1EK2CNorDA0oJ9+/hwgzqWKuK5xv8BMUXmfKqtWu6qD92jVVJvwViiiuECugnk0X7SAkI15
	kwtQO+jzURAxZ7AG2NWG+3jatwPs7wZJVA/PaVYyCZAW4esIEMtYe6grPiDBdckgfTGRPoYSfmv
	NWIm4qPGCtYNjM6PbH5kKu++Q0b4T6pO4JktYxsqvBXizHDGQQOJlm0WCizfrFO05oXaJ50QF/3
	PtXly+YHSm2jRW4HVTxu3990OBdYc8yByTAHvpyBwu1cXvtweswyUFGmNUq/O6C/kgeQdKjCjQG
	T/eX37iauekcBn5G4u33UGIega3qQ48vH2b3l42ClXMzjvtHTGiHnVO7i7hEimBvXpkw9YCmCEL
	NZUf3/7tUONtNph1tCMXemQ9kQoUIigbAQWYf2gzGCNkAoKASHcS48zEe2QOa7m8ddRexoR8bCt
	D12Rl8w+4l/JiHeMqofJdlpRD8WpgJ0yothFPv+zzN7KjbSzkSQyeCSXvRf/t4pgQpzTH8j
X-Received: by 2002:a05:6512:6718:b0:5c1:57b6:c731 with SMTP id
 2adb3069b0e04-5c1bc55528amr2860372e87.0.1795440549518; Mon, 23 Nov 2026
 05:29:09 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-build-speedup-v5-0-0f6018be8dae@kernel.org>
 <20261104-build-speedup-v5-2-0f6018be8dae@kernel.org> <sashiko-outbox-199744@kernel.org>
In-Reply-To: <sashiko-outbox-199744@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Nov 2026 14:28:57 +0100
X-Gm-Features: Aa3M54p2MuaVPrel21pLHhiv7_UQjxDcbruYJqUL7bjr4LeGvFh_ddwRm4qiHrQ
Message-ID: <CANiq72m57kFE5LTjT6V0Vajbwv_oPFEVwkBWgp5B2Xhh1E9uFg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] kbuild: implement and use depcheck to check
 dependency timestamps
To: sashiko-reviews@lists.linux.dev
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> - [Medium] kbuild: missing fixdep prerequisite for depcheck in scripts/ba=
sic/Makefile
> - [Medium] kbuild: concurrent Makefile.build runs race on .depcheck.mk.tm=
p and .depcheck.mk

I have been using some of the patches of this series for something
else, and I have been hitting these two issues that Sashiko mentions.

For the first one, e.g. `olddefconfig` in a clean tree can give:

      HOSTCC  scripts/basic/depcheck
    /bin/sh: line 1: ./scripts/basic/fixdep: No such file or directory

The suggested prerequisite fixes it for me.

For the second one, e.g. `make -j4 rustdoc rusttest` runs two Make
instances on `rust/` in parallel. Most of the time one of them prints:

    rust/.depcheck.mk: No such file or directory

and sometimes the build fails:

    rust/.depcheck.mk:1: warning: NUL character seen; rest of line ignored
    [...]
    rust/.depcheck.mk:22: *** missing separator.  Stop.

I hope that helps!

Cheers,
Miguel
