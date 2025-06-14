Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11314170A26;
	Sat, 14 Jun 2025 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749936497; cv=none; b=p4Z+w0oYr4U1kRcBo/Fy4PJ2UbAtVJ+2PPWCttazIOo+2EP4L0jUWZCt1YCcj0GYRASE+zoDJlThdtlWVvd/o13XEF+1D+eEdBR7h1DpWlgUQlEtcslcKNQK2J1B2SU7lCGkxBqO/kMQ7OBndk546w5cORK46o4u4HvFMslGiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749936497; c=relaxed/simple;
	bh=c/J28r/JLXHW83WD1oCAc7pgMinEjT5jwvrbBAFF8kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1IYWEn6FrplJGCvZhby9AlGmBgRUzHDqsFqHNKbwUgoQb+iL69aoizrkHde+gWjRZsxrfP36wBnud7/xWE3OImRzUex8vxys9AQ6sAS0k5/69L2v1p8/H0b/Kzx0lNNzsuNDVt/QN/ZqC5vIQNGfZD5xj41ZvgKNRgAoazFQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chL7MZ5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chL7MZ5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44149C4CEEB;
	Sat, 14 Jun 2025 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749936495;
	bh=c/J28r/JLXHW83WD1oCAc7pgMinEjT5jwvrbBAFF8kI=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=chL7MZ5m80b3LlPWPzGUpb4Gxg41WA3qMq+W/bBnzShZapivw8PzvuHdPatrhvGP0
	 YyLAKzQVjhwbX4MN92wIXmAkQN8sEyh3R26NbpZlpB3osioIHx+p0O7nJKRsHROYaK
	 ym8HCJr+lSfZHl8MV2+6g/PgZ1sxostbEkWL2JItLlbNX2uNVr89saa137hrvdv4CT
	 aixlxUKsB/5anXprYMH+Btm5UknYTIjq+uL/ZlkDeLmNiXAos8Y+FNGZnyOcIWH4X5
	 seEm5jYxvSm7518aTB6kImMzRsHAqIxT/oOv/F3rQMhHlerLWYeFqn0Z0f817p9h+r
	 5YVDM2k4Xg6qg==
Message-ID: <7cf40cd1-fe0d-4493-ac15-e70c418e54a5@kernel.org>
Date: Sat, 14 Jun 2025 23:28:12 +0200
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
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <c7dbb33d-98b6-45da-be77-e86b9e6787ee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> This seems to be off by one. For instance, if the loop reaches the last
> valid type in mod_mem_type, MOD_INIT_RODATA, and successfully allocates
> its memory, the variable t gets set to MOD_INIT_RODATA. Subsequently, if
> an error occurs later in move_module() and control is transferred to
> out_err, the deallocation starts from t-1, and therefore MOD_INIT_RODATA
> doesn't get freed.
> 
> If we want to always start from the last type found, the code would need
> to be:
> 
> 		[...]
> 		ret = module_memory_alloc(mod, type);
> 		if (ret)
> 			goto out_err;
> 		t = type + 1;
> 	}
> 
> I can adjust it in this way if it is preferred.
> 

My earlier suggestion was incorrect. We can simply initialize the memory
type t to MOD_MEM_NUM_TYPES since it's only used in the error path of
module_memory_alloc().
