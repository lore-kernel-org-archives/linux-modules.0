Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478A2737FF;
	Wed, 16 Jul 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695246; cv=none; b=YgY5Xo/2496BkVw3RoSlAKrNjsbSIDI+7x9OyFFZFfvXj9lv8F3RlSByIXLbxjugsemcuwp75aMdQaDS7NpQge6tnyMJQ2mpHSMTBmA3Q+mQEIJnYxCTCrkF/yei21BRBR8tP32TvqNY1SzzARSbYWENpG96yZx23L1CXJdDkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695246; c=relaxed/simple;
	bh=JyKUvJx6D7rN3PbMXsN8uzlXP0z8IlxTSoGvQpStzrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glHzY5Knsxtef/6yO1QP12u4S2uYZU0oh+lUiOT2EBWFL+7KwPtms0hWhJdEL35YYeUwqEZlVjfQ/Ft3+tsQQv8Woug2dfZi+GIav5xIyCV2X5iLdFXkhZj7+mxlzirKHf9i688j8WQoD9gtOGcW7PMa7xIROvJze4Nv5oS955k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLWaX7JB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLWaX7JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A564EC4CEE7;
	Wed, 16 Jul 2025 19:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695245;
	bh=JyKUvJx6D7rN3PbMXsN8uzlXP0z8IlxTSoGvQpStzrk=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jLWaX7JBUkLJXJ9YpuORgUFFGvOhuPGtNIbSo2ClwAPDjyvRmnuJmkEJgDfDcG9Uq
	 FYZ5HH8OQ2nJeoL3E0ejqWxQZHFUhkYK9pUkhFzX2ZpOJJGHmSHBlilgQ2E9UTfRAK
	 cRkZaEURFG8+HU0NqKIj4LZitt4nrSL/L+j/4JRItzJFU4OVFRtpcO1y06jZsSbw2H
	 NGUZzGqOPXyXruiLwcmkpuHaf+95wOROQ1MioODNgWD7a7XM8OuF8Cl6GjAtZs4XeK
	 OZ+Ddfh9VeTxBa+1SM0WqnaKCq0QlXy5wxIm7fx4Ho6DQ6NXO68hnT9IySbQejBuQ9
	 mUrHFIdXKV6qg==
Message-ID: <0dee8b80-1bb9-4d34-9b39-344e391d56f4@kernel.org>
Date: Wed, 16 Jul 2025 21:47:19 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/5] module: Prevent silent truncation of module name in
 delete_module(2)
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630143535.267745-1-petr.pavlu@suse.com>
 <20250630143535.267745-2-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250630143535.267745-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2025 16.32, Petr Pavlu wrote:
> Passing a module name longer than MODULE_NAME_LEN to the delete_module
> syscall results in its silent truncation. This really isn't much of
> a problem in practice, but it could theoretically lead to the removal of an
> incorrect module. It is more sensible to return ENAMETOOLONG or ENOENT in
> such a case.
> 
> Update the syscall to return ENOENT, as documented in the delete_module(2)
> man page to mean "No module by that name exists." This is appropriate
> because a module with a name

Including the NUL byte...

> longer than MODULE_NAME_LEN cannot be loaded
> in the first place.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/main.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 413ac6ea3702..933a9854cb7d 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -751,14 +751,16 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  	struct module *mod;
>  	char name[MODULE_NAME_LEN];
>  	char buf[MODULE_FLAGS_BUF_SIZE];
> -	int ret, forced = 0;
> +	int ret, len, forced = 0;
>  
>  	if (!capable(CAP_SYS_MODULE) || modules_disabled)
>  		return -EPERM;
>  
> -	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
> -		return -EFAULT;
> -	name[MODULE_NAME_LEN-1] = '\0';
> +	len = strncpy_from_user(name, name_user, MODULE_NAME_LEN);
> +	if (len == 0 || len == MODULE_NAME_LEN)
> +		return -ENOENT;
> +	if (len < 0)
> +		return len;

This looks correct to me. The new code not only returns the correct errors
indicated in delete_module(2) but also checks for the case user passes an
empty string and the case where NUL char is not found when copying (with len
== MODULE_NAME_LEN) as well as it's using the correct length (MODULE_NAME_LEN)
for copying.

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
