Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717F1B5808
	for <linux-modules@vger.kernel.org>; Wed, 20 Nov 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732139704; cv=none; b=l0gqWAcwRy52LCdMyBB2Ps+OpwDS1bjq3av4bM1iNtKCwYE7dZISx0jq3y57wpOmKYWBUkyGT3garbeq13oZgvac885o8usbK9hsXLT1IdErPsAuQTVMZZcQdn6/U7Dpc8MABDU5+PUsJmgA2/PTjflXQdwVGDjzi6wALMnX3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732139704; c=relaxed/simple;
	bh=p/2HQRb8DSnOeN4sdRAF0ATMaB8otlVUnnqv1o1FzGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmXFXmpJJoWjJK78pLPCHmU4iO8JJQ0HCeNh+lQ9YAzzN/v2yxlhtJGe0zVb9d7nTaxcjuKUNH2vI62pMf0Sl+1Os263FxjXMT3W+lvtpjeOgWxTMEts8VJjSuL8uX3IdS+W1NMYFBFloTGEhpZkvuGWpVts96OiqO1MJZUu3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4Y0f/gF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Y0f/gF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-211f1a46f7fso42085ad.0
        for <linux-modules@vger.kernel.org>; Wed, 20 Nov 2024 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732139702; x=1732744502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJuMd+zGRgDKZ9hMGh3NL+Uf9ATMzUJl+LIc+tHuySg=;
        b=C4Y0f/gFqtdzQqNOxa9+YQDrWocL074QKpC6V0Xo4T4sVirP5UJyUolbJXhtl2KcoB
         mvCoVYzQFhflAHmHgqnKqFUrwV1TkjnNwb4ywWFTAAsWQvqQeM6ETxtn7bG/NJgkZg52
         dVZlRHGWKXntAcd6YXUsBH6TmfzJONqtSBaXS9eC+oGpUaFI3VmuO9r3E/FS6Z2T2Yct
         hNKS/XOwneUIzbnC8/typZKVL3XliTMPo2qAxr8zNHzP2fYQ4JkOGaVE82nk5/H+t4Ou
         uAjaH/iva7OEaRPpbPX342xMr0r9FB+dv4jgjdfGW0bXM7d/knDrHr5Zyho4xrECMY4K
         wEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732139702; x=1732744502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJuMd+zGRgDKZ9hMGh3NL+Uf9ATMzUJl+LIc+tHuySg=;
        b=YapRqTpoIDyYi8KxFUeb5yPMEZZGVqytY7FZS+RI6/9Pew7OO3EXUS2Uz6PK18ygNp
         H4l3slfp+cpDcZncJ4SX7WWwNoqrrfASc2Li924NNKeYSxE8JQYAJjcLfAngkxsozItZ
         vzUC8LCz9PSssJXXTIiB7Rl+P/BIJFuTvyqJPtRvSRUTUO1x/4/pkvm9bZqpB41mxryA
         6TIxmsdD8tqNBlUeJbCrE6jGHJbZ8vzbgJfHjHzVrARuBo0WaRobO74/EyBD3NdXp6Xb
         WmCEtWAz6VI1XEky5nFhAWgsdmIsZibuMRTuhdLk8AMaFv/UAuabXcENkTOoSvC2Cf//
         34xA==
X-Forwarded-Encrypted: i=1; AJvYcCXJrTJss8tRUquExH5M8AV4Vch/68ossG5W8S1luv6npUIxFF76gzQ8OO36lk+HzcgwVSnFSist6AkLepY9@vger.kernel.org
X-Gm-Message-State: AOJu0YyodpvpMPESpjzrza6IiHzQN30BCKHY4Lt/p7e4a4qOSAHL2MH5
	Sb+vcoUHJEQiE9vamUv5EYfWCj2d6Q6C/sybfXIcRIFga0V7hfOOO512Mur5Rw==
X-Gm-Gg: ASbGnct1r2IVjLhok311alueRE/VkagLk+HgQfZt19iL++1sjocPmBCIbvIomvOIq1C
	7Kn2oWvDQvrBhhk9bAdoyraqDd82Zz5RSoKrVmMlfZaz4lGmQ3m4dTE5Jk3ut2L75LV8/VsYKIs
	/XWWzUYBkGeNTWgA1hlv/2/qKzlmo8cvheEIhMpnWX/h2iDg7UpVfvgXEFT/LrmnTlREWDBCFKY
	ap517XMpBz+rqK9y99qhJr5k0DNYfWSDKjbc8iAXDCMRSxqiLY/Rl6IhdtH0/zoncAtKO+l8tiU
	l0ggvUu4XTLB8Os=
X-Google-Smtp-Source: AGHT+IGKc9ZvPmJIK0nWwQcxR6PLarmpQvpHzkZoZJMXfvRSrnEfA5c5NwlyeWO3fgYs+0aWUjKJ0w==
X-Received: by 2002:a17:903:178f:b0:1f7:34e4:ebc1 with SMTP id d9443c01a7336-212878a076cmr162705ad.5.1732139701962;
        Wed, 20 Nov 2024 13:55:01 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212880d16d4sm271285ad.167.2024.11.20.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:55:01 -0800 (PST)
Date: Wed, 20 Nov 2024 21:54:54 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
	Miroslav Benes <mbenes@suse.cz>,
	Asahi Linux <asahi@lists.linux.dev>,
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 10/19] gendwarfksyms: Limit structure expansion
Message-ID: <20241120215454.GA3512979@google.com>
References: <20241030170106.1501763-21-samitolvanen@google.com>
 <20241030170106.1501763-31-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030170106.1501763-31-samitolvanen@google.com>

On Wed, Oct 30, 2024 at 05:01:17PM +0000, Sami Tolvanen wrote:
> 
> For pointers, limit structure expansion after the first pointer
> in the symbol type. This should be plenty for detecting ABI
> differences, but it stops us from pulling in half the kernel for
> types that contain pointers to large kernel data structures, like
> task_struct, for example.

We spent some time backtesting gendwarfksyms with android15-6.6
releases to validate the kABI stability options that are currently
implemented [1]. While we discovered a few missing knobs that are
needed, we also realized that pointer expansion limits don't work
when symbols are removed (which is possible without breaking the
existing ABI when TRIM_UNUSED_KSYMS is used), as the processing
cut-off can change. Petr also had some concerns about this earlier,
so instead of coming up with an alternative solution, I'm going to
drop the pointer expansion limit in v6.

I still think that it would be great to come up with a better way to
limit how deep into internal data structures we go when calculating
versions, but I suspect that's going to be challenging unless C
grows an annotation for public / private struct members.

While looking into another version stability issue compared to
genksyms, we also came to the conclusion that private structure
definitions in .c files should be excluded from processing as they
are opaque outside the CU and cannot change the ABI. I'll include
this in v6 as well.

[1] https://github.com/samitolvanen/linux/commits/android15-6.6-2024-11-gendwarfksyms/

Sami
