Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795049130;
	b=Kh2Ybq9hJalxjXYa3Yr7AaEe1UCggveAOjM3oPKsBJW2CUZwdcItVMtVZOHYsxTr5s3J
	 9pSV+G+6yPN1xLKg9D8oBuYPpGMC8/AjSzVKAkDXFS7eIBCnaX+m/1nNkl038CB0k6lGg
	 Q1nDpXBPZix78VEsj3QKdeZb8NYdExkRI+AYYDrl7R+oipOmbIjUJy4BslzpjkRZUki4H
	 9p93KfTdsdI1NdchTxqfJKdTDJMYX7KuZrGErwrIdUDc1L/5bZHRJYDufHctEY9qNUEFV
	 uT1yKDU0ObAmj1torpbmY5lu/R04PO9GFzJTzQPGLVamsk3CcSjU8uNfG/FLDjEhpzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8sS940tCKYm9vcpUdjMxPgdq6c4Dw9nIfl/dAmKtgNk=;
	b=A2d9JgQDGmMrMPNAXwEWfLy6KuWet84EBcsOuJCr7p9vCXbpKPEkqYN7LZDC96x6uU4Z
	 Ne8w3rpavVan3Y4/x/pEEm0asyriThawY359STEYZq6dwUEBcLsWRjW86JEX7gwoni9qe
	 3jVNEXhMVwEnk70lODtQZfsEsfXAziK03QNsmM0TpfNAz+hf3B5In4lZyUMNPwfjSZzQq
	 7MfZAcLsRysnnEj5aqoY2873jAU3XkHcT2zF3FGakdHFjzamDJnNvG1umzrJYXN7EjX7p
	 c4kRaWa/ezgd0owO3bADK0rmZS8pePqzvNx+kV8C7Da4BoFa/EXZM8PtCKp0razZYwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dctIdyXN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC5C606A32A
	for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 00:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC5C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dctIdyXN
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6860f867so12745e9.1
        for <linux-modules@vger.kernel.org>; Wed, 18 Nov 2026 16:45:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795049128; cv=none;
        d=google.com; s=arc-20260327;
        b=N5DynYc6pbxJhiRS75csjoTxt5EwMhqJ3Qj9qV3/mDOwsJ+fli7rrJ04/w+HfQuQ+0
         U9asZNcACLakA7yj2Q4J4sw/WO++ZeRrNk1axdRraiJZg5+Mn6uPV2qBSd6pPQEm6BIK
         J9f2Z01o+x0+KTaiDL12vnhUHNg3AJ4NjvHiW+6lqUJzh5sksRYhfpCvea9KJdUgpEBC
         659jhJKZnWm7b7lXk+4Lz+sY/ktTbd8Kv6kYDq2PQeRu79y1XVIzuKnx9W7Qi3trlLGO
         mFHjrSSu7+8ltREVgJgamVR7Qh88rtrtKCfsntPS39eCfJeFhepYSomuWNFaZpFFt096
         J1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8sS940tCKYm9vcpUdjMxPgdq6c4Dw9nIfl/dAmKtgNk=;
        fh=pQAMElc+lpxOWoW7DkPac2FWWvSeFMhJcNzcZLWkNJY=;
        b=TRcxDIjbMN6gPCix+9X8WQOkDXeLs7Z1lBoTb1Q9KPGrfqW6hocT9vfg3+G+ZVOq08
         UYtoaQOFUdeeHre26R8FRFdS3Vrig/b/v4F5GgFOV4trHohFvFH3nUraLE1IK8zclZ58
         0tnQ2ZwdyvdeMFrYaPb+s5tGGGR7PnSfnjQTVW2TyKxBHMYKYU3eT90ovMSaI3xze+2A
         jXrmC9cyzAtdMMnxJt6nSfO2ROw4nb3v2eee2KcbhRqnnGu7Jy4cX7qo1ypQZBZ5bJmj
         i8Y2coPcY4RcOvbTEQS9eu1/PRv14fb/S9/ossvxN2JwnugN+X256zlANIyYwAH7X78g
         UTMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795049128; x=1795653928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8sS940tCKYm9vcpUdjMxPgdq6c4Dw9nIfl/dAmKtgNk=;
        b=dctIdyXNTFOmu6P0yiuU9EAiTrjaoKS6u0AaJF9HmA281BEX+p/zl88sqijdx+DJq9
         G+zNh/CuWCQpA3z6cdByYHBnHi73s8VrPdRcpMFzr7xvXitN21kWHC5FzKzmkpG59TDx
         FtwXO/GJxAl9BDXtP1kwFFehq0N2jkz6gaXMh8YWVP+KDXMgJdAx6Pit8Qo6+8esR3sK
         hJdI4Mz3Y3QuoMv223DxSF9/bh1THeZMuHLgNcQRNeZjYKjktisXU78Eref678HFwQUQ
         lgC9TQ6Dk8hv0ofuQ4L0NwiX+aeR9CxQKEyygnbsFjq61cg3Pi+fkvrtILQgIQ4oaMAx
         e7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049128; x=1795653928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8sS940tCKYm9vcpUdjMxPgdq6c4Dw9nIfl/dAmKtgNk=;
        b=ouZahITRZ62+ij10kcRlS47rJSpSsAQufBR65Ds85LlxPePN4u68FgRmTJKfFqRGol
         Wq+C2e+B/C9clbFWx3ZgwruXzKczFbLpVLeA9Docqmho784zenY5PZpmY7lsed57oDIl
         0CVNjq/Qyho3SgFtQYXMFtwe3gStM7P1WKsq5nig9kEpBRZx+LrL7GSZuiZO66Lsl5Yy
         4BUNSyUrKWQNJXFRevSnJiyJ8Zi8a8cG51djVM2Zl5CIkxaOcOxOKeK6BgfMhyYBTemE
         n906n5I+/Dmpiclz58WSAJb8Cdo5dLybnvoVa1BUY7tmbVAuJmS/ikU3xiiYMInX5A4v
         Eg5Q==
X-Forwarded-Encrypted: i=1; AL+hErFA9cRlnL6wd2YvzMSmylDvqURbJKrEqXQhfCb2w7WFiLMDMtuQNRqrU3782GTOZlypF8jOd/t74Gl+p+Q4@vger.kernel.org
X-Gm-Message-State: APuU4Z+XafX64eCeVO81mLH/eXi7/rozFjpS8bWjHGbAH1kB8ws2WP15
	iDvgbU8rOl8arQdfjS7Hjiff7E9RvVluWKvFIgRNkubausIf+FDMjUOFXhDdBQ6vG1t27SF5nYO
	h8YCUVjqBWC/9NnVJqW1Qx1Cg+9qDOCnnhi0wb+Mh
X-Gm-Gg: AYBFou3HD1c7VZqzyUbjPNnE9v53lV50i+4zWsCC6BwgLOVVLhNWLVXNYgcdc4RGF9D
	0JRZ17dDEtcgTuRPclA2h+koMt6kxuz3qOkI/aAew5HyIVSVZobIt+KMTZjpouEbjLjOgCaoaWd
	2rM4hMhSf/TRrCN/v6HvRg603vupWnWOHZfU90WXg27UUND3p7qCnhmNtEt/W4hIuAC9mUZZAts
	ZARaiQKRl1eASRAY3xIJFntd7blQ84YpkTgUM6BB7sSuTLJzUgWgYFHmiTQnWX+QdAPuOWk+0a4
	dLgeWRNFON0vmgh0RibTVTYTncnFhKpFKTB2IiaVcFm742tXGpP14BVb3yFebX86kwdu+qZfv33
	lU2ieoxGJBlJhmd77ORHiqhkZ93gbufmIBw==
X-Received: by 2002:a05:600c:5489:b0:4a1:e368:cbf7 with SMTP id
 5b1f17b1804b1-4bb84b99968mr104985e9.0.1795049127672; Wed, 18 Nov 2026
 16:45:27 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com>
In-Reply-To: <20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 18 Nov 2026 16:44:50 -0800
X-Gm-Features: Aa3M54rPrnjXnHBMBUtGdNtQCrNUnFqzZgAcYH5tW2jPXgiVWnHrDJiqQAFq-hM
Message-ID: <CABCJKufsw-egbnyqc3_D=+D=AdPQN-Q2bi6-uGi3e6UV_FZkKw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: generate a symbol version for rust_build_error
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:08=E2=80=AFAM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> From: Peder Bergan <peder.bergan@gmail.com>
>
> CONFIG_RUST_BUILD_ASSERT_ALLOW exports rust_build_error to modules.
> When CONFIG_MODVERSIONS is also enabled, modpost warns that the export
> has no symbol version and records a zero CRC because the build_error.o
> rule skips gendwarfksyms.
>
> Generate the checksum from build_error.o with the existing Rust library
> rule. Make build_error.o depend on rust/Makefile when module versioning
> is enabled so incremental builds pick up the change. Kbuild's saved
> rustc command does not include the gendwarfksyms step.
>
> Fixes: ac61506bf2d1 ("rust: Use gendwarfksyms + extended modversions for =
CONFIG_MODVERSIONS")
> Reported-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1201
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
> ---
> An incremental x86-64 build with LLVM=3D1 CLIPPY=3D1 clears the modpost
> warning. The kernel export and a Rust module that references it both
> record the same nonzero CRC.
>
> OpenAI Codex assisted with coding and testing.
> ---
>  rust/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
