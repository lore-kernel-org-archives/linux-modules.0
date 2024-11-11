Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04967189B83;
	Mon, 11 Nov 2024 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323937; cv=none; b=sLgfKUsYt4Icy4ijXYpAJpKFBblAxseDGzAbZMymijpHOaMRWxm4bYFRI8yZFYiWZoLWT+/ULxLfK4/hIL0B7TbmeNwzxXvEuRD9VBZ0vaAQrI1eFBExVqn4wBd1fo1jinTC80NsoeLOrjeh3RMCgGDQLTmJAMR+byykxd1dJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323937; c=relaxed/simple;
	bh=zrKN+Kk6LABKwC64I8YZImNpWv0Y/Xnd7VicAcZ4VGE=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZYQhM1pQUVQglMe3syf615lNujeAnz+6/MGqW03crx/LWGBqAckFpq6FLJOunr106bwX1JjdTj8o0rS6WEON7xPAmwVi4bCw2evXKIyx2tWD179SgYFMJtNJpLtQGPKjXZFN834tUv97Ymf8sgM8pNnqkpnjZnReFZLs46bUb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FWaIP3Gt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FWaIP3Gt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=tewDbZ7xlWajYG2q+Y503VyTvdlWVk+qIhd0sPZvhHk=; b=FWaIP3GtUCQ8HY+draJMnjqFm8
	qkuKmq+xqgGsaaTXq5G5g5Y4fawA/cUycAL07omopc7qIBqZm1RlwMZe2fLhpztugp/PKKszucqdF
	qqSXSw1UsS7mx+PbnhO4w84VRQMblgq621sa3jQSsM1sWYX1z+i2oqbTb51XDcUTIo9wARRld/dJS
	/C6ShmbLijjigks5FmAR/JJb0fXsM+iQYi7fr7d7AWlNWtFRuPEtwntTCSu2jT2IZeq7DUNYbOezx
	SlJpO5B6dumMX4bQvIxJYUZP4ad+QeztEnOdxwCZZGCQlXh19nO6+uAARGRWK4LUKwox90vBAQRcb
	wcgJgKzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tASRT-0000000Cpw7-20fE;
	Mon, 11 Nov 2024 11:18:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F0452300DF3; Mon, 11 Nov 2024 12:18:46 +0100 (CET)
Message-Id: <20241111111817.024009933@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 11 Nov 2024 11:54:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mcgrof@kernel.org
Cc: x86@kernel.org,
 hpa@zytor.com,
 petr.pavlu@suse.com,
 samitolvanen@google.com,
 da.gomez@samsung.com,
 masahiroy@kernel.org,
 nathan@kernel.org,
 nicolas@fjasle.eu,
 linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 hch@infradead.org,
 gregkh@linuxfoundation.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 2/8] module: Convert symbol namespace to string literal
References: <20241111105430.575636482@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

git grep -l -e MODULE_IMPORT_NS -e EXPORT_SYMBOL_NS | while read file;
do
  sed -i -e 's/MODULE_IMPORT_NS(\([^)]*\))/MODULE_IMPORT_NS("\1")/g' \
         -e 's/\(EXPORT_SYMBOL_NS[^(]*\)(\([^,]*\), \([^)]*\))/\1(\2, "\3")/g' $file;
done

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---


