Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF71EF39F;
	Tue, 17 Jun 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180656; cv=none; b=tkLQAtwguapsxf079gDvpLkxN6P3ZNoRYFpv4W6bv5jdJlAqjBPocaGczyWMroZ5soz9Jhcw7tkDeOaec/mFscPkboCmhCQ+a2yECXq84yYjw+HdfQIx78tWa2mcthnilLkIHax418WXtLt/egfCrtWOy5KzQyc/2hLGDdGPHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180656; c=relaxed/simple;
	bh=Ys/A26/nKtP0UfmYYHt4uHbOtrmbM5To6KwBk23zyIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCLGpACIe5DuQIkqwIHSbaFuFkYYFicMfBAOX1BUpzMA1jWFt8di3CWe9JQ98g31DpSNzsi0APB6N9wjIykltOHYSKs0GXOtMYdwk3MZYvgY0zUKGKIHbWzzF3qMvSne++SD78yNxrzx0jNFz7/Btg2fUNsmxnOjIkync6dHh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAiptaa1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAiptaa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E355C4CEE3;
	Tue, 17 Jun 2025 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750180655;
	bh=Ys/A26/nKtP0UfmYYHt4uHbOtrmbM5To6KwBk23zyIQ=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QAiptaa1h4FcJzrEvXJ9tCipwYGtHpBn8qabljNP/gtBgC4AyJhESn6/VluD8MxMj
	 s00TxfiMotIXZ6MHz0s6upsGPX9mr/0bT882zGDiTwExR13K5y/vOL4jU8S24QLLUR
	 9SPwfjBcoJmFCjTASR6Bw+hzDN6oQIAoMEsxSyN2dLcJqx+/aMw7BUj4zV5Gw0H92z
	 T00OxVbBcHAuZzCYtYuyxUOJ7to2b4o9TU1x+9QjRK241qZHWb5Hgq8UzRQwRU3pTa
	 qmQkFJ95zKb4A8qeSPwFc9+hJXpnMQLrfdvLGUvxq9GtU+3zE4Ku+thrYocwmetWW3
	 BpWHefNNgwc1A==
Message-ID: <bae6e1f3-efbc-47d9-8eb4-653f851311d7@kernel.org>
Date: Tue, 17 Jun 2025 19:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-2-petr.pavlu@suse.com>
 <ae967353-71fa-4438-a84b-8f7e2815f485@kernel.org>
 <c7dbb33d-98b6-45da-be77-e86b9e6787ee@suse.com>
 <7cf40cd1-fe0d-4493-ac15-e70c418e54a5@kernel.org>
 <97f26140-bf53-4c4d-bf63-2dd353a3ec85@suse.com>
 <732dedee-c7c5-4226-ad87-f4c2311b11b3@kernel.org>
 <2c277bfe-3086-4007-bf04-ef229e6cbfb7@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <2c277bfe-3086-4007-bf04-ef229e6cbfb7@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



>> One thing though, we are "releasing" the memory even if we have skipped the
>> allocation in the first place. So, I think it would make sense to release only
>> for the types we have actually allocated. What do you think?
> 
> I noticed this too, specifically because move_module() is inconsistent
> in this regard with free_mod_mem(). The latter function contains:
> 
> if (mod_mem->size)
> 	module_memory_free(mod, type);
> 
> However, my preference is actually to update free_mod_mem() and remove
> the check. The function module_memory_free() should be a no-op if
> mod->base is NULL, similarly to how calling free(NULL) is a no-op.
> 

Sound good to me. Perhaps a different patch type for cleanup/refactor. The fix
here would be back-ported to stable branches. So these are 2 different things.
