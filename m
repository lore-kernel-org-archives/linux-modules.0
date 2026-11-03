Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721424;
	b=HSMTq6/oUBPQzHpqAqcydbmzoN39l6H3On1oVeBAONl19i8p8hOY9Q5hV95UpL+sl7Le
	 djpD5djOq+08rjxJoFLyuUk3Zm3OAjn7M+/Dr7wCSnUTDhJMhtmJwfbVzxkUWVu7FGRMv
	 FK3vQH72FWiN/Wyh0sOnlec7bCPV0WRdvoaSKIFeY/32DQVL3uf7wZvN6kECq5cVPiRII
	 FnxDidSwKCsJ+6AINmODZPYq+Z2awXFiMQrpDtv72pSbwAOSIbYCA/MSs7aZpxeBohG7P
	 ox27U581ToG+0BQUIJX0zxuzzWqZHM5XZyqbGM1ZW8HbWXZjsKr238GOrVnbvZHuumg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ds1cm/r+J5ogP0Oi85siueuJoBsjSaeimvYRj3GfO3Y=;
	b=XWMbVGdTiZoa45dgRB1U8b79lgfTRRxvEMJLTnpxDN6UxkHik8O9rukWZKtwwIaO3Dxl
	 7Pr79qniCebvqygRqe0P9D/B+iLXGqOkEnYIem3JJejdwn0qhwZyOajtxvFsoJVoCeYa9
	 ckAdAubKpFh3jWjgUpM0+yrxZ/nA6opmWX5Aa0zILXHmqO1ThL+Mo+YrCIwTCDikePoXu
	 GFTV4vX6Wyma8tTeu9DDzRRupKjl1BT5RUzIDDVqbOCTwDq+ERH9pbMQlYVmG2F8LBtzO
	 oDJHcu5zvPQSFPgnH+Zyj5EzyMX4e25lcCm6NoVk3QyjBC0+SFroB+ZBUtQrMwGYsLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="OQyd9tD/";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21287606D839
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 15:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21287606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OQyd9tD/
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so35293345e9.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Nov 2026 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793721422; x=1794326222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ds1cm/r+J5ogP0Oi85siueuJoBsjSaeimvYRj3GfO3Y=;
        b=OQyd9tD/8TQOt52lQsWFnhzNzYJd8rgIeATGn0HbW5YbJ0qOm+aUzz0gKTIlMS6Ux4
         8uXXHnbExRiP5Huc8SqpAIpjf/AXk42hAjhNh9I2I6b8OqBuxh/3LSRu1Jn3j43FBHqJ
         S+XkV8xg48nTjJ88cEsHAmkY7hhB8I+9GD72G3LFAmt7QH04WMg0Vvjswb3glBMJDVq7
         3JwXc+h9z0GFb05Uu8k/fl/T8MH8whVD05s5kNu/lcbwdaa6H5eQ9hjAak1unQMOgBNd
         +QWzAdibssaKAE3bpR3DOmkPcVDpdmMp4YtT6qELztOUIfqWNP8wqKYlhRielrP122BQ
         9k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721422; x=1794326222;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ds1cm/r+J5ogP0Oi85siueuJoBsjSaeimvYRj3GfO3Y=;
        b=nkrn1fFhZsQjAAZOZUuikYacAsXe+fKLdYRUaqIaEHX2tuHmmOhzE2BjcOtp3WRxfu
         ULVkvdk1DTBvlUNkAH5AgGz4EgZCpyCJUjxZSx/kA6oXkEPlpQeLX5dtn3Ns2xqAn0Kc
         pB0UzUr9U3orx0FjIxJxPmpnRBrhPIe997Z2rxrakbv+YDE+mCstFhJmTkjDhJx6Cilx
         0Kk9u3luOgXJqyTEj+wUWCybXwhmklx0QSSYVzM/pmy2dPvHgHEeT0rKZfgdns2vqGRx
         47HBYW8nR2gMKOdXLflWvtYYcVlHRrsmPKr08nKY3yMV9TRBH5ubTLtrYIrOZ081FCbn
         2f7g==
X-Forwarded-Encrypted: i=1; AKwUvByiCdxtnqIL+nAZ6qXWkawJMcxYqpVt8Z8FKxwNIbCppdvulCQElJvg5yf3B253dL10J0lDTt7nBuf7jZ8/@vger.kernel.org
X-Gm-Message-State: APuU4Z/9Px//G3BxXB6Kw5TPAMSMIP1Dt2p11g865vV8ClsJzWf5ZFEB
	hyRC7NiYt/kEzotq1WZ+tfyQcLMD/0EbF+BsED0eF3j3dyTqBfFPpDuwKoijxDZu09g=
X-Gm-Gg: AYBFou1vaUz54Yw8GUhb7xirHWRSc2SntZyyaOsCUHCMaYtxfvM75856ZBp/bvJ8ueQ
	wUypr7QfmqQCoPVQBzFm0MHc+tb4zGC5rQYGY28kxf4RHLHjTyzPeeNUE42EC5bZ+BNXioEhco9
	MkFYomhk9+7DRlDx8S8EZn6Z+R4OCntdupb+sBTmvaVGf2nfCki8iKPKBivPMBqHMjmwCI+F0A9
	JJ0BslDh+oxZlMj79DL0Ck8aA3ukIgeZ0FU4mKo0bFmcdBbpNFADxppjzOiTqUb1SnobIBh6W3w
	5mD+J67L5f2BZO9FFWR9U3z2UFST3QF53hMbM8TV+r/m9H2tHjmGKWGCiyHZ6DYGP3c8Ptinkbw
	b9aEQ7T3QXBfWrn1iS9PQQwtZaU1WUPgmAVr0zzfdoVNd/RtgIg3/uTP677jdRnmLS4g952ky+G
	IwCe8nn2znNqxnJrgE2gigvjPPztRi2d5XXxvhWUTE63Jnoh+kx19At0OL5SPhKN/Ur6UandJdl
	d9R4Mrp/VCXBV4Sm6ZsOuFLSTHIgdwDETMveQqlzaWiqd5aOkokF7+LuPzEBBWSbBxQzxuofsbm
	c1vUBU90/o7jTMmYxnq+fBQATmusiHBd0t/qeVbvWhQ1XG1qS2I8vCpP2ZkHdEL+nw==
X-Received: by 2002:a05:600c:e555:10b0:4b2:61e5:b2f4 with SMTP id 5b1f17b1804b1-4b261e5b38bmr58131845e9.11.1793721422629;
        Tue, 03 Nov 2026 07:57:02 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm25946508f8f.23.2026.11.03.07.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 07:57:02 -0800 (PST)
Message-ID: <0ddac462-b4b3-4844-8a00-fbe5f043885c@suse.com>
Date: Tue, 3 Nov 2026 16:57:01 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: move EXPORT_SYMBOL_RUST_GPL to
 include/linux/export.h
To: Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20261022134617.228229-1-gprocida@google.com>
 <20261103125814.258105-2-gprocida@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261103125814.258105-2-gprocida@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 1:58 PM, Giuliano Procida wrote:
> diff --git a/scripts/misc-check b/scripts/misc-check
> index 40e5a4b01ff4..b39d731cb413 100755
> --- a/scripts/misc-check
> +++ b/scripts/misc-check
> @@ -45,7 +45,7 @@ check_tracked_ignored_files () {
>  # does not automatically fix it.
>  check_missing_include_linux_export_h () {
>  
> -	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
> +	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_RUST)?(_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
>  	    -- '*.[ch]' :^tools/ :^include/linux/export.h |
>  	xargs -r git -C "${srctree:-.}" grep --files-without-match '#include[[:space:]]*<linux/export\.h>' |
>  	xargs -r printf "%s: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing\n" >&2
> @@ -58,7 +58,7 @@ check_unnecessary_include_linux_export_h () {
>  
>  	git -C "${srctree:-.}" grep --files-with-matches '#include[[:space:]]*<linux/export\.h>' \
>  	    -- '*.[c]' :^tools/ |
> -	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
> +	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_RUST)?(_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
>  	xargs -r printf "%s: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present\n" >&2
>  }
>  

This is minor, but the updated pattern matches non-existent
EXPORT_SYMBOL() variants. To preserve the current strict matching, it
should instead be changed to:

EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES|_RUST_GPL)\(.*\)

Alternatively, I think the pattern could be made more permissive in
general, something like:

EXPORT_SYMBOL(_[A-Z_]+)?\(.*\)

This has the advantage of not requiring changes when a variant of
EXPORT_SYMBOL() is added/removed and shouldn't sacrifice any of the
desired functionality.

-- Petr
