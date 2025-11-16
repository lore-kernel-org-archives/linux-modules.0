Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EF221FB1;
	Sun, 16 Nov 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763325772; cv=none; b=ho/lZAKHQXG7UHEo3F0FMnTJZBqIyz9z5YDCFXGFETdiopURhrARfx1sN99+SUyDz2sy2o2tHJCUPQLwt0Gic3nOmZobfwvmoJ/Qy/tGvoQE/G+IW+gV9KrxC39v0PqmL3Wes5YYUfFPDjMjcv2LuMqVg1srrlwP7Y4KfU0NvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763325772; c=relaxed/simple;
	bh=L9mm6RZkEtZZw3YJtGPngE/RLxsaiBMNq7GLUKrCZoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2VgJgm/95An27APc6/kwf8QXuO48gKuVAf5j9AmpCnC50h5BqmmMiVLmosCzA1X8/BJS9RlYULRgUknYC3S9no3mqXgtx6aGGUTTSbK81aMMCUVZAwrxEiusOMnEU6+Rl7BTj7shTsy4GHV1TaF2Q3VbvOTEnQVsBJ4BmPE4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhfel4Me; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhfel4Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36CBC4CEF5;
	Sun, 16 Nov 2025 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763325771;
	bh=L9mm6RZkEtZZw3YJtGPngE/RLxsaiBMNq7GLUKrCZoI=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mhfel4MeVOfaZBDb0rVLekL+IY7/ASOIgEa6s982h5rvS9YqtFPxxAUaZAdNOowq3
	 hqCtEtt05ek2XHA8nQkrkOQ83ec6yiZu3XVht5dB1j+Cf+nffKVfwe1uUkshK78dXG
	 opn4U+4xCvouMHVHL/iOfQHNgF1gbBeiWfkfGxHsfdYw9eZP+yNTxN+WtfkuH3jazj
	 PiNTLhGBiBVaJwUh1+Tue6ogQkUm4Pou6TW5KyiMH78JqNQZm48ylqIkEhA10Nb+Bg
	 YEwi+Rgb/mnwiOpyBWuBRmP+cDZz21fJ4zdOvcOFvBsByWhqKUHEv1wHnmPffuPVKY
	 pbA2k+oo4zShA==
Message-ID: <81b10186-767c-4904-b048-d88a73ff15b3@kernel.org>
Date: Sun, 16 Nov 2025 21:42:48 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/2] module: Override -EEXISTS module return
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Petr Pavlu <petr.pavlu@suse.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
 <ea36d12b-15b9-4c1c-b81f-75834bc3269a@kernel.org>
 <geqat2upyxwvqjsp4ietmeypf4gmeoerg6akstbvelnxe3zpl4@dzqhyolsvtvc>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <geqat2upyxwvqjsp4ietmeypf4gmeoerg6akstbvelnxe3zpl4@dzqhyolsvtvc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2025 16.31, Lucas De Marchi wrote:
> On Mon, Nov 10, 2025 at 04:17:47PM +0100, Daniel Gomez wrote:
>> On 13/10/2025 18.26, Lucas De Marchi wrote:
>>> The -EEXIST errno is reserved by the module loading functionality. When
>>> userspace calls [f]init_module(), it expects a -EEXIST to mean that the
>>> module is already loaded in the kernel. If module_init() returns it,
>>> that is not true anymore.
>>>
>>> Add a warning and override the return code to workaround modules
>>> currently returning the wrong code. It's expected that they eventually
>>> migrate to a better suited error.
>>
>> I've been following the thread (and apologies for the delay) and reviewing the
>> patches, and I do not believe we should push this workaround. While this "fixes"
>> the bug reported, it also hides the real problem and drivers will continue
>> misusing EEXIST at module initialization.
>>
>> From the bug report thread, I agree with Christophe's suggestion that
>> nf_conntrack_helpers_register() should return EBUSY instead of EEXIST. This
>> would fix the root cause for this particular module and will allow others to
>> change their module behavior, if we also follow up with proper documentation
>> about EEXIST.
> 
> the fix will always be for the modules to stop returning EEXIST, no
> discussion on that. This is the messenger, not the fix. Someone starts
> seeing this warning and rjeports the bug. Then the developers can fix
> it. It's much easier than dealing with the outcome of a module returning
> EEXIST.

I see. Thanks for clarifying.

I'm thinking to merge this at the beginning of the next release cycle. So others
can also have time to process the new warning when testing their modules. I hope
that is okay with you.

FYI, I will follow up this with docs and some drivers fixes I've found.

> Also note that we already have a similar reasoning about adding
> a warning for module return codes in this same function.
> 
> Even if we had the means to check possible return codes from all
> module inits, we'd still have external modules.
> 
> See patch 2: after some time we can simplify the warning and maybe even
> remove it.

That was added almost two decades ago. I hope we don't need to wait that long!
:)

commit e24e2e64c468c8060bb7173abecdf11d00ed5751
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Mon Mar 10 11:43:53 2008 -0700

    modules: warn about suspicious return values from module's ->init() hook

I don't see a way to completely remove any of these, especially with out of 
tree modules... or to capture any possible future/new misses.

> 
> Lucas De Marchi
