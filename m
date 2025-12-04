Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6131D6AA;
	Thu,  4 Dec 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849129; cv=none; b=ITH+4upMfm1a6yY0TEpEcfwP0T1Uz9nNz2PEaam6Zp9SkEovnrkGZSiavHpq+8TwMzuBy0uMWGlqCrwfdVh6ZPuo8cZA2FM0UzmgCABPQPgwn+ngpTyM8hIuoz0YWp0+CDAEB21cRABndpcPMbfoZB5vBC/sQDW7Xec15lZGVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849129; c=relaxed/simple;
	bh=4+ago9RcB1V/RAZJY3SUXojT88ytoljJuAHL0Qj8ORc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V1Gqer8C3qwmY8X+n7KmRDTN+rww/adGt/Mid1ZfXcHfx9Cl+kHMqwRRL1AxY72u67MQNusluWcYi+dzggAcRcJJ6EGzQ+jxaB1axeQkd4ur9Hshychreqcv83W8IIA3VssQRoIKYsNXK6HVJE+gZxrZOYG3+mnxdIzQ0EpvSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgC/cfgS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgC/cfgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D43C4CEFB;
	Thu,  4 Dec 2025 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764849128;
	bh=4+ago9RcB1V/RAZJY3SUXojT88ytoljJuAHL0Qj8ORc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jgC/cfgSbsMZfYmT4aesgCYglo33a2FgHrwI4QPLfupPyevEVB9sQKAXQ6YhUsu7e
	 ULZO6htBx2JY4aaGeXEQ4R27JGpAEPztvOs6uBH6/Pyn6UirRBd6yey3aMWtqGPH5e
	 R8vxUGSeFJD6tQZfyUicOztS5L7Mwlf9rUpp4Q0RP2SfBzgaMk0knm21ZuySRylT69
	 KvsKbsnyVgqWdh0BulRbe2KQiQGW8Dw6V2aNIAFaLWB4nzTnLqf5GZO9CWofI54NdA
	 BO2xj0vbySXEpXo85v+CZdhdNmst9r7ZM+hLTycNB/qhQz5SIAuKKtHBTCAKoimfQe
	 i9wouv1BJkKBg==
Message-ID: <7dc0f103-ab0b-40db-b246-a1af40afe4d3@kernel.org>
Date: Thu, 4 Dec 2025 12:52:04 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Modules changes for v6.19-rc1
From: Daniel Gomez <da.gomez@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, Andreas Hindborg
 <a.hindborg@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Aaron Tomlin <atomlin@atomlin.com>,
 Kees Cook <kees@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251203234840.3720-1-da.gomez@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20251203234840.3720-1-da.gomez@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/12/2025 00.48, Daniel Gomez wrote:
> The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:
> 
>   Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.19-rc1

I know the preference is to use git:// but my git config resolved to the above
link. Here what I intended to do:

git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-6.19-rc1

> The changes have been in linux-next for 4 weeks. Recent 0day reports for UM [3]
> and arm64 [4] builds were not reproducible and traced to a buggy bindgen version
> combined with unreleased clang-22 in 0day. The Rust team has reported this to
> 0day.

FYI, this has been confirmed by 0day:

https://lore.kernel.org/all/aTEi3KUUkPVGS3ix@xsang-OptiPlex-9020/

> @@@ -329,25 -179,30 +332,30 @@@ pub(crate) fn module(ts: TokenStream) -
>       // Rust does not allow hyphens in identifiers, use underscore instead.
>       let ident = info.name.replace('-', "_");
>       let mut modinfo = ModInfoBuilder::new(ident.as_ref());
>  -    if let Some(authors) = info.authors {
>  +    if let Some(authors) = &info.authors {
>           for author in authors {
>  -            modinfo.emit("author", &author);
>  +            modinfo.emit("author", author);
>           }
>       }
>  -    if let Some(description) = info.description {
>  -        modinfo.emit("description", &description);
>  +    if let Some(description) = &info.description {
>  +        modinfo.emit("description", description);
>       }
>       modinfo.emit("license", &info.license);
>  -    if let Some(aliases) = info.alias {
>  +    if let Some(aliases) = &info.alias {
>           for alias in aliases {
>  -            modinfo.emit("alias", &alias);
>  +            modinfo.emit("alias", alias);
>           }
>       }
>  -    if let Some(firmware) = info.firmware {
>  +    if let Some(firmware) = &info.firmware {
>           for fw in firmware {
>  -            modinfo.emit("firmware", &fw);
>  +            modinfo.emit("firmware", fw);
>           }
>       }
>  -    if let Some(imports) = info.imports_ns {
> ++    if let Some(imports) = &info.imports_ns {
> +         for ns in imports {
>  -            modinfo.emit("import_ns", &ns);
> ++            modinfo.emit("import_ns", ns);
> +         }
> +     }

This last part is the only non-trivial for this conflict.
