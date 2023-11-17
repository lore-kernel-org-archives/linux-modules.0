Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/MhAHSE"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82163A2;
	Fri, 17 Nov 2023 10:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C80P3w16fs62eEEe4oyApwGuwCnUYxn0YKlH/jCHwaM=; b=n/MhAHSE4jHjt2CLOY1ufmqw9X
	JckfqhKeZ6MGg5h6TCXxL60IN0qzdL4k06yLalFI7HfFw5UfwZkGlhDhsKYmbKBf8FVJ0hhqt05Wa
	JrswkPr0WQDZ9FqEaAhAJE0aw92Zf7K7VQuPlevN8gLDhLDvYRazAbx2tlBkN4Oc22uGMkE1eCY1X
	dvdEp2V9gCyz3D3cb311pllFsnW6Zx3pNMfuAXpsYACUTEHRNtNYBhdd2HmXriXwoOG1KVDVKw5q5
	zTbjM3KO9xFQX68XeLkORG86DiYGTAs1hKY4Kz5gKgstmfg7woRmIzo8nMDmezYZ3c9JFKzJ6rkKm
	J10E7aTQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r43f2-0076OF-0I;
	Fri, 17 Nov 2023 18:33:48 +0000
Date: Fri, 17 Nov 2023 10:33:48 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Modules: Introduce boot-time module signature
 flexibility
Message-ID: <ZVeyDDLe9B+Aij2O@bombadil.infradead.org>
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
 <20230914112739.112729-2-alessandro.carminati@gmail.com>
 <ZVZS4hw5dGB4aPz3@bombadil.infradead.org>
 <CAPp5cGTcRGp3z=xbA1svxLYz1LC74_AQrTPSXNmACPRYrpporg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPp5cGTcRGp3z=xbA1svxLYz1LC74_AQrTPSXNmACPRYrpporg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Nov 17, 2023 at 02:56:53PM +0100, Alessandro Carminati wrote:
> Il giorno gio 16 nov 2023 alle ore 18:35 Luis Chamberlain
> <mcgrof@kernel.org> ha scritto:
> >
> > I see the code which skips module signature verification and the knobs
> > but I don't see the code which complete the promise to do the actual
> > signature verification post initrd / initramfs state. What gives?
> 
> My initial intention wasn't centered around providing an automated solution.

It is not even an automated solution, it's *any* solution. So to be
clear your patch simply disables module verification, it has no
solution.

> Instead, I envisioned a design where users could manually restore module
> verification during a specific point in their init scripts.
> 
> It might be plausible to restore module verification when the rootfs is
> remounted. However, this seems limiting rather than advantageous.

The patch as-is describes a lofty world and does nothing other than
disables module verification. If a patch disables module verification
it should just do that and describe that. Nothing else. The subject
of the patch tends to suggest some flexibility it provided but does
nothing of being flexible, it outright disables module signature
verification. The commit log and the patch subject description are
describing something completely different than what the code actually
does, and it gives me to the concern, to the point that if you didn't
have a few commit logs in the kernel I would have thought your intent
was test kernel developers with some AI type of code that does something
stupid and very carefully crafted commit log.

Nacked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
