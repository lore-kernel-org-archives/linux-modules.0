Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD249552D;
	Mon, 28 Sep 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589476; cv=none; b=JFIQCsyr6OF0gXbQ9dGzKIaP7G5dxtADWs5iTyHSkZtXkiHGiU4HxpwCXE6aQ8qljOEOyig4UmeumsP75VuI+h2ml8tBVOqj8pK/vjsud4YKslQskiX9MfGa47zFzbY5uZECv4Dmpee2XzwPrngDqnKzXJEAKg9wLpBs0dowz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589476; c=relaxed/simple;
	bh=gahcTOLE0N8cyBxKfVjqf2G88KQ6EJwfzOvB67dQrv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/LMdfO9OfPqeiQ3301Hxit+WNpIJYqJZzW8PoljZfpElkkBGpQb1Nk1sQkgMZDDgo4uN6cP8y6fXGtcwSEYmbAx+vmuMiEfx5JOTgxAbSBiVcGfhvVJq8F60af6iE039sjR73IYMdnAFaGDFfGFcf2hWaFtmnAt9sOhfrxJWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhBP8ZQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhBP8ZQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DEE1F00893;
	Mon, 28 Sep 2026 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589473;
	bh=gahcTOLE0N8cyBxKfVjqf2G88KQ6EJwfzOvB67dQrv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZhBP8ZQ7bV12wp22rpbYfnlD1HVau+UWZu8/dgQBY6zOsChjmQkcEWj/u7b+8W1Yu
	 8ZD2XM4g2irbOb0k7JpUHTxoNfwS+CqQjvhUDW6cdvsrsy8H9DbOGUWPWreMsFH21c
	 QN/dIes4q2CaXdIsQXBETt3JUUuMvit/pEiwHp6Y8e72LqVHLiH8wtLaEaoR214y5L
	 19D/Wfv+SNxNo92bJ5CzE2H1SO8sQWWoEyFxLelUc9MzDCjmkccV+iYRHQFAJ3blgq
	 dF25608NJaGJFrUNb09PsQtW5dUI6k11I9Ijk90qLW36hpCLqpH5rNxIzQQ3n6WgY0
	 FB+lguVG3lIfw==
Date: Mon, 28 Sep 2026 10:57:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
Message-ID: <aro6APF7jwSAvohf@gremlin>
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
 <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
 <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
 <1dff448c-9cbe-4276-bca1-d91283b0c7b4@linux.dev>
 <b8005c24-ecac-45c4-840a-fd282f9693b5@linux.dev>
 <aq1noAdz9U3tXH_Y@gremlin>
 <aro5L-W-439tTICi@milan>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aro5L-W-439tTICi@milan>

On Mon, Sep 28, 2026 at 11:53:51AM +0200, Uladzislau Rezki wrote:
> On Fri, Sep 18, 2026 at 05:35:02PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Looping in Ulad who is best placed to respond on this.
> >
> > Ulad could you look at the below? Thanks! :)
...
> > I think best person to look at this is Ulad as vmalloc is his baby :)
> >
> > Ulad, what do you think?
> >
> > Thread is at
> > https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/ for
> > context.
> >
> Uh.. I missed this. Let me check!

Thanks! :)

>
> --
> Uladzislau Rezki

--
Cheers, Lorenzo
