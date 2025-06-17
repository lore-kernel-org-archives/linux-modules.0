Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29D216E2A;
	Tue, 17 Jun 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153666; cv=none; b=FWxpRRX8SM8cDDh3iKvCJ63A0Mapo4I8n2SWJOnnMcIHCi4OdNCKuWmEtgu7Jgv678LGrxGGvjU81Rw9vijJ+/6gGZgvKjERUO2Dwqc2eAM4Ck6mK9HKJjy5jkYp5z/ATyXKlSqXDxbXqvzjDmWqEsMiMDetYhVd8rpzxyAfPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153666; c=relaxed/simple;
	bh=R8cTAtiMle7UEhDpjDC2ZuxOyUKg/f+iaZLe1m/EkIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk3mkUqZmjJq/2gX7ODKC44ZzmHOHlH7AIwdRO5IsdvEwyk/dDPxJC8QHl6zbRbq0Wh6frsbjS2zeFi2ZZW12So9ucRfN7iulav1HbI815ATHDnFoaVWH5IlB45oshmC0OALAhKJDJMbFOVtsjQloOID3OB4Km+Jd3ZZYBcd+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdZB9oL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdZB9oL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DE9C4CEE3;
	Tue, 17 Jun 2025 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750153666;
	bh=R8cTAtiMle7UEhDpjDC2ZuxOyUKg/f+iaZLe1m/EkIU=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pdZB9oL9Pau2ljXdyPBKgs/iPLVU6LGn+jjdLkj5wKHW3NDv0syHL15JeKEdBScWj
	 CQ8YFETAmL295GPSzHByQUkMY5OGUYUYxpizpxtotICby8f6PWeKB4O6rh4GmKmhBs
	 6L7WkIO4M6yw8KXs3JYrarnLQEfY1Du29fPW6TQ32cmf4UAqiHSOFWlo53gHHt98C0
	 teNV+xY9AY2ETQamKvawMHXbgBtRkN0DoUcyRVxjEdlAyGydlJ0dQ+pAG6K+GePUfg
	 BEImkhle5kNQ8vNOP+lIGnFKHDmlFYQy8DfvZKf55ClndBmnrp0ULm1P3LdLSqZ0tM
	 OnfU8Lk38BiKw==
Message-ID: <732dedee-c7c5-4226-ad87-f4c2311b11b3@kernel.org>
Date: Tue, 17 Jun 2025 11:47:42 +0200
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
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <97f26140-bf53-4c4d-bf63-2dd353a3ec85@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Do you mean the following, or something else:
> 
> static int move_module(struct module *mod, struct load_info *info)
> {
> 	int i;
> 	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
> 	int ret;
> 	bool codetag_section_found = false;
> 
> 	for_each_mod_mem_type(type) {
> 		if (!mod->mem[type].size) {
> 			mod->mem[type].base = NULL;
> 			continue;
> 		}
> 
> 		ret = module_memory_alloc(mod, type);
> 		if (ret) {
> 			t = type;
> 			goto out_err;
> 		}
> 	}
> 
> 	[...]
> }
> 

Yes, that's it. From your patch, moving MOD_MEM_NUM_TYPE assigment to the
initialization and use the while() loop suggested later on.

One thing though, we are "releasing" the memory even if we have skipped the
allocation in the first place. So, I think it would make sense to release only
for the types we have actually allocated. What do you think?
