Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AB38237E;
	Mon, 16 Mar 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651524; cv=none; b=t8u5b8nN9X1xFqnVfnfTxLjsXPjcpmkvZOUixKYBcb+KVY+yWe3cPYrda/P+6VtaY6lPVhUsY2jpkHbmRzeA1ZsOZTexW3p8UT5BYy7mGsDNirRgygVzTq+DsKYbAdQQbBSCc6VfLWjbsPS8QqI6ARMV+XqELmr0QvqAPN9uMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651524; c=relaxed/simple;
	bh=b5bxuu+7UOI2HJ+XJxrOFLC3oeujurp/cJvri+V5Olg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2KFCBMUe6VHpRzw8nEdWEyxGArSWSTdEE60DBqOY/HzA+SyNp7+7tI0gAZ83aH6gO22tqX5myqGyENMlYm1IzB2z0ZGI6rOqTgS7jGFrHkhsTrbbXl0fJTLN9rYgU+b0QOO/wL4G9BxITf6uEOIr7rMYVPVVWGeks7TnJDx34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XqI/6Jkf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XqI/6Jkf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jQMdZ2z7aoWREzbq3JjULurAAiyQF08kqT1+g/HJlqQ=; b=XqI/6Jkf4C778G67ScbhsZtCtL
	vfaaTufVgjvwKuOOBM3P5hJ/G6osDrzB3kWIB25WbPadfzhgAQ+IOiJLtUgGYgbV1Bv/smCbhiRkJ
	8SgZnoxTdItSEaT9NHM1RFOnYd18QPqB92KOWWqPHWeFXCyqpAIRrSRyq8J9WCKlc81PTYFNkXJZS
	A3ObGa0q9kAimYpugb3NsKP9jAIM6cm3CRSLegVUdBpKWrAJEz0goNNzslD0aov6cX8PeB4YRmPDP
	jN9+61tm45dMIOTI8DMi66aZn7r6McJUuo8T5NCnjwQEoOU314I64ZYauk8BLNA5K2XEnW86TNKLF
	doN3oPPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w23mb-00000003aap-0YWq;
	Mon, 16 Mar 2026 08:58:41 +0000
Date: Mon, 16 Mar 2026 01:58:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <abfGQUxgm8mEWlAz@infradead.org>
References: <2026031341-evolve-repeater-987b@gregkh>
 <2026031303-prelaunch-creation-3fce@gregkh>
 <f036410e-f53c-4284-b108-18bcdb2f0d28@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f036410e-f53c-4284-b108-18bcdb2f0d28@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Mar 14, 2026 at 11:22:22AM +0100, Christophe Leroy (CS GROUP) wrote:
> > Sami just pointed out to me off-list that maybe I should also drop the
> > srcversion stuff too.  I'll gladly do that too, does anyone know if
> > anyone even uses that anymore?
> 
> If I understand correctly the text in kernel/module/Kconfig, srcversion is
> added only for modules which contain a MODULE_VERSION.
> 
> So as you drop MODULE_VERSION, srcversion becomes completely useless doesn't
> it ?

Looks like it.

