Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63623F27B;
	Wed,  9 Jul 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088467; cv=none; b=Xr0SoEax1ivFLax+xl4fCCMWtwyjR/ErL/Xq6VO7/EDUtgt1f/zV764zZsb3meX3GFGXEU76t4x+22bC3DwGPkbTW2VnDDuc2H0aB6ZkhJbGg3rUV8Nh4t/JeVdXuP6/o5VcLP1boLc8GRT4ztdrtDhJSbGoRnt/Nnlym+yJivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088467; c=relaxed/simple;
	bh=lXj7b+FMDPoEuzp6HwSgKhhfp/QE760CZyhdiMfiUMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbcRT8UOehaIn3lANmwy9FXw+2MLucceUFhzeJqr2/NRSZTRodfXUIwxjKj/MnjpWe+rIBB7UYBqoF+CGGk95Jr9AckE487d6LRejQD1PJAiuLjYuI7uzpRT/E0lfmsVRe9kRJS9ewB6qQm6re5E8Dr79CgQN3foR8IeCGFLTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOUKt68d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOUKt68d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67500C4CEEF;
	Wed,  9 Jul 2025 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752088467;
	bh=lXj7b+FMDPoEuzp6HwSgKhhfp/QE760CZyhdiMfiUMg=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QOUKt68dgdstjFOJwIo6U9Z0GV738Mp2JHINVBeHNr2CkkSsOMTWBHEhLOI9TT4F9
	 nDn0FHKLdo1p8m8dMQZqIhaqJ89sFznR8eH9HXphFNz7uck4qARifwEvPHOKtaEm00
	 O9colAvETLm4UyTJvJXZH9pXqnyb2EzAv9UdC9zTJJuZBxmnrFJi5ocPYt/nJT9fwv
	 ueK+nEPPFkn5ydNokv3rjeMif4ZbO2jD9NxeptJN+eD9nodzo0AbNcwoYmQ77LBsHy
	 hN7LSf953Rom5/tPmfuM59O3rSRS0qtlVvaE7MtFoosLsLMfFvSqbDYwXBnzt4AswT
	 fxio3q8AeWBLw==
Message-ID: <64c1b31c-a65f-4eaf-b343-0b5b9b2c1086@kernel.org>
Date: Wed, 9 Jul 2025 21:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [GIT PULL] Modules fixes for v6.16-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20250708193822.45168-1-da.gomez@kernel.org>
 <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2025 22.21, Linus Torvalds wrote:
> On Tue, 8 Jul 2025 at 12:38, Daniel Gomez <da.gomez@kernel.org> wrote:
>>
>> Petr and Sebastian went down to the archive history  (before Git) and
>> found the commit that broke it b3b91325f3c7 ("Don't relocate
>> non-allocated regions in modules.").
> 
> When mentioning git commits in other trees, you really do need to
> mention *which* other tree it is.

Makes sense. I thought there was only one history tree to search for this.

> 
> In this case, it seems to be
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/
> 
> that has that commit, but that's actually a kind of odd tree.
> 
> The typical bitkeeper conversion tree (which is where I suspect the
> full-history conversion then got it from, unless somebody did a
> separate conversion) that contains that commit is actually
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

Thanks for the link.

> 
> and there the commit has commit ID 1a6100caae ("Don't relocate
> non-allocated regions in modules")

That's it.

> 
>                  Linus
