Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3537F725;
	Mon, 12 Jan 2026 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240604; cv=none; b=j5nWTzHy2WzTI9pkLH6EPPgI1sIxUJ3OtVUKtp6uOumQMAwH/RUFUESESKiuSqqMfWHRLR/9VTO8XSZwIwhzLv+kYypM9f/QBJhAAyXAOsRuWyhX4meO0UNFVkgpKtW5eO+9pmrIpwJXMUhB/axhqy+HSmxKOGcp5Xf9lnlix5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240604; c=relaxed/simple;
	bh=E/0UwBEpH0BaKAKu9v/Kjl2ty4XCvDfh1hWKvPxSr2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQYzgf/+gqDR8ExFu8/jQPhUetksZBn9yRbPKwxK52PPCkJxg2GOb31dcZensZ4/p/AwvBSmQZGwrGsYRXJs61HLk1+ux980VhWowBLPhyZRIqz3pP8CYvuytRb5Gn5SuRYEmihVcLw9qG1VUCdVt1CmQ8GcVusfBxCymLoYc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgStf7Bk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgStf7Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77680C116D0;
	Mon, 12 Jan 2026 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240604;
	bh=E/0UwBEpH0BaKAKu9v/Kjl2ty4XCvDfh1hWKvPxSr2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VgStf7BkKbS8akNsv3NXpxDmPNMsI5eSY8me+ulB1MLQOq8DA/qGkzNBKU+U+r9LZ
	 S140OY/Zf20XAN9/WnnXQTtrYPrkYBvFTkV44JtoJl40BS1TG6/EBQwR1FYDUXOuQR
	 WwUBXNEXFX+AgznZEqCFSJOavp+NOTZ8l7VxeUfaL/2M0cd+XgryduuA3c/xSWaZ8T
	 1b9Edj5UMjhbQezQWGjXNnH3xrEbMYAr+o4BdsKrmd/1ci6dzEMJr6mzk/hILEh/yu
	 v3KIKR6tOG0ozIKcZDTaghZ9YWhsFEp8GwVsyCe47VVSSKZG0WxPyxiC+XphWe43aJ
	 MFD8RQYd4T0hQ==
Message-ID: <c2d900fc-5f59-4da4-9600-eaf6546beba4@kernel.org>
Date: Mon, 12 Jan 2026 18:56:37 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 00/15] rust: Reimplement ThisModule to fix
 ownership problems
To: Kari Argillander <kari.argillander@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Youseok Yang <ileixe@gmail.com>, Yuheng Su <gipsyh.icu@gmail.com>
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/01/2026 à 16:07, Kari Argillander a écrit :
> Still RFC. Not all people for each subsystems are not included yet as
> this touch quite lot of things. I would like to get feed back is this
> resonable seperation and how we will land this. I have tried my best so
> that it can be applied in multiple staged if needed. I have not receive
> any feedback on this series and that is little bit worrying.
> 
> Introduce new ThisModule trait and THIS_MODULE impl.

Shouldn't it be called this_module instead of ThisModule ?

I don't know much about rust but this naming looks wrong, it is the kind 
of crap we see in C++.
Linux Kernel codying style says:  ... mixed-case names are frowned upon 
... [Documentation/process/coding-style.rst, §4) Naming]

Is THIS_MODULE a constant or an enum ? 
[Documentation/process/coding-style.rst, §12) Macros, Enums and RTL]

Christophe
