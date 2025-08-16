Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844B23D7EA
	for <linux-modules@vger.kernel.org>; Sat, 16 Aug 2025 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755387213; cv=none; b=eAjT8CX7UG9Z+DdBEOLXVEQqS7kw7PXCuA7M5s+rrS+iINl9rl1/5jJjmaCpC37WKP1HSa7oI4RyncjqjNX2Alv9z34zOK1J+SwZYLvUEYqcaC3iNpIpjqxxC6QMWEj/UEiUw7oAzGgTQerkxd6iM4sm0oNX5wwZ/x7Qr3+0mgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755387213; c=relaxed/simple;
	bh=wENS0exNMK5jiMj9l3ev94WsfAIc4FdBkFc5xAkS+d0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tvRUNWkW3SgJsVJ0mtiXLIZuC/m+gk5CjppIIxir7pgUb5QjPomhjgc4RyyYkpP8ceyelnHKd4luxGk7o+PzrRa10MYd1mnXgyWaltD+HTG2YQZoo1xONKTdhnttbWnq0OZKnM5jme9NVAqGLMG1hgkc+Wp308RmuJ/IVV/x9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=TPdDw5GE; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="TPdDw5GE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wENS0exNMK5jiMj9l3ev94WsfAIc4FdBkFc5xAkS+d0=; b=TPdDw5GE/JMUywZUAXsj8phJSw
	Z+5o8IEwCdBXIbrnV/FptmZkgWqcg55tQLCjm7pjRbxVZDGCGnNeOoRvrJvtbFCpZ1P9FmZLl6Pay
	jnMjxjwm37md+Db4jnj0fYTm8/D5hg5ss2fm7aexwicurestD4TsgRR6iGzt6lrZDqA2J1g01y7kB
	F2RPnin888HXSMlmkUb2Mia3rlP0T1i0uKFs4+cXMRLmy5aXRqRMhQoUCh63yZYWocy6WsE617wbv
	R7Y2JAG4NpkwbxxzNk6r1I9LrSl9I6BcibCoz/VzUKd9/jGgJdRUyJi2pcKb9/H9jQO6tPT7oMLAd
	BbPxCaRA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1unQOo-000000000Sq-3lTc;
	Sun, 17 Aug 2025 01:33:22 +0200
Date: Sun, 17 Aug 2025 01:33:22 +0200
From: Phil Sutter <phil@nwl.cc>
To: linux-modules@vger.kernel.org
Cc: Yi Chen <yiche@redhat.com>
Subject: modprobe returns 0 upon -EEXIST from insmod
Message-ID: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I admittedly didn't fully analyze the cause, but on my system a call to:

# insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko

fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
tcp'). A call to:

# modprobe nf_conntrack_ftp

though returns 0 even though module loading fails. Is there a bug in
modprobe error status handling?

Cheers, Phil
