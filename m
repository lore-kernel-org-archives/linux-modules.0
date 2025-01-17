Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863F1E9B2A;
	Fri, 17 Jan 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737079255; cv=none; b=jgfs3aND3IKHDGIWebdHHZ1qtAINfMifL/ZZl3EMXrDXD+TSySAnRxEX4jZQlu145CzW/vY5DdMPNntMRMJmuoXPQRGlTROjiU2zZ0pMGYfFnUEEAadtlPUAJAXLyS+tcx7ukp+qIaQyMUSs38LzPqA6dsnRPnLW9rOgOvoTd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737079255; c=relaxed/simple;
	bh=Y7Oj+ttu5T3urFoe3t0Iiw0EuYPk0Co9Xpg0i9Kb3co=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kAMaTTwyTYhM7aTYoCXnw4+UyY3nrpjEOz0RFNx1c782+Nz629KV7UadsN6ZCfjKn3aRvpyRs20rUkHDa8hoAEU9Wx4AUgAGXlgJrs0WOE9KR0FFOjsqr4FRCfNt5kZcPNun86P3qde5yn8f17fz0FIa/43PBFoDPMfCi01d+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2489892009C; Fri, 17 Jan 2025 03:00:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1DFA692009B;
	Fri, 17 Jan 2025 02:00:50 +0000 (GMT)
Date: Fri, 17 Jan 2025 02:00:50 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jan Beulich <jbeulich@suse.com>
cc: Mikulas Patocka <mpatocka@redhat.com>, 
    Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
    Daniel Gomez <da.gomez@samsung.com>, 
    "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
    Helge Deller <deller@gmx.de>, linux-modules@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
    Sami Tolvanen <samitolvanen@google.com>
Subject: Re: Unaligned accesses when loading modules
In-Reply-To: <9bab8b8a-1e63-4b40-aa1e-6d6a88cbeee8@suse.com>
Message-ID: <alpine.DEB.2.21.2501170148420.27432@angie.orcam.me.uk>
References: <1665d54c-178f-ff72-e627-776e7c76798b@redhat.com> <CABCJKud9RCJzVZ2VuTRoaBavOC9bnyTv_W_-AC3mGOy9AY7dWA@mail.gmail.com> <aedcb0fd-040b-0dcc-8c28-34a0b07d5a7e@redhat.com> <16bf04b0-64ad-4614-957e-2971f053949d@suse.com> <0144332b-be9c-2f6d-81bc-a18f13990d65@redhat.com>
 <9bab8b8a-1e63-4b40-aa1e-6d6a88cbeee8@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Jan 2025, Jan Beulich wrote:

> >> When you say "broken", can you please explain what it is that is _broken_?
> >> Things have changed, yes, but the produced ELF is - afaict - still within
> >> spec. The "partial fix" as you call it wasn't really a fix, but a band-aid
> >> for some broken consumers of ELF. Plus modpost, being one such example,
> >> was supposedly corrected already (Linux commit 8fe1a63d3d99). Said "partial
> >> fix" was also confirmed to help modpost [1] - are you saying that wasn't
> >> quite true?
> > 
> > By "broken" I mean that the file offset is not aligned to the section's 
> > alignment.
> 
> Except that this isn't broken at all. The section's alignment has no meaning
> for the file offset (in ordinary object files that is; things are different
> for executables); it solely affects the eventual virtual address assignment
> by the linker.

 FAOD for ET_EXEC/ET_DYN files section alignment has no relevance either 
(and sections are not required to be present there in the first place) and 
any tools are supposed to cope with it where applicable, but what matters 
is segment alignment and that continues to be respected.

 NB there is a way to produce optimal code according to the architecture's 
capabilities for unaligned accesses where required, by using the "packed" 
type/variable attribute.  I'm sure there are usage examples already there 
in the kernel.

  Maciej
