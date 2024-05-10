Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FF170849
	for <linux-modules@vger.kernel.org>; Fri, 10 May 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340174; cv=none; b=AqMvL66xl0EY8qQkQmtVeTQb9HqSD07GXN7zD5VzbEQBbPIcpRNWH/AF+Dn5UVRJDExMUxtqtdtdptz9hiCdjK1hpxIfxV8wzNFycWFRnhfxplGLIKSEvO8LfinJYmNY6EyU4bJf+9fggmx8nfJR3WZZDVg9Sa30lJJ7vUfcsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340174; c=relaxed/simple;
	bh=gLtn8iNbCFDPbGTHeSOJuJbYJweI5RzQTSWGmPZPFOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qnPyu+iJcbvF+hpWJQIWiln2/T89SzSeyzOVgGzq9sCZaXxh3lxIQkpzxv4f1yACZofFDep2T4fj0oxfV8o08hC4MnGqLx1hnHACyuQgCK9i/RSswiuPihLtLAMWa/ziSFz+u2r7EPLHW9dyOBQwuLbb5V8k3stTY9EH/22nykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=k4jHdu/n; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="k4jHdu/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2752; q=dns/txt; s=iport;
  t=1715340160; x=1716549760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NiDAXLDSiKY2ApqZkYFsFmyoDXMK2HLjY40hrfDh9nA=;
  b=k4jHdu/noTgbexGfD7hUtEAgV3knRZFcLw9fWdNWB5m4lV0qTnMcoVix
   ecS3XYfeENTfpv8BbzG3CAcaLWcbrAUbXaE193KWHE7cBuHcIImmygUjz
   I5QqW7rXw60Af9+phivWFXGAgoJka6ZMSSoumsM8QqgLHhYEAIlFjHpvV
   A=;
X-CSE-ConnectionGUID: 2KZPmB6ZQOCrxN7ZNKCT6g==
X-CSE-MsgGUID: GabFqdiPQA23PFuYxqKEOg==
X-IPAS-Result: =?us-ascii?q?A0AuAQChAj5mmJNdJa1agliEGEJIlj6LdJIZgSUDVg8BA?=
 =?us-ascii?q?QEPRAQBAYUGiDoCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQYBAQUBAQECAQcFF?=
 =?us-ascii?q?AEBAQEBAQEBHhkFDhAnhgGGXDYBRoFQgwCCZQIBsTSCLIEB3jGBaxiBMI0Hh?=
 =?us-ascii?q?WQnG4FJRIJQgTeGBoV3BIpxiFiBWIUsiXGFVEqBIwNZIQIRAVUTDQoLPgkWA?=
 =?us-ascii?q?hYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWCQQjAwgEA0QDIHERAwQaBAsHdYMxB?=
 =?us-ascii?q?BNEA4E4iX2DPSmBd4EOgxBLhHaBdw5hiSAPBwVJQAMLGA1IESw1FBsGIh9uB?=
 =?us-ascii?q?6VHBz0bNoIGKhuTQIMPjlifL4E8hB2hLBozqjSYYqQkhGOBZTpIgRNNIxU7g?=
 =?us-ascii?q?mdSGQ+OOtATIzU7AgcLAQEDCYpoAQE?=
IronPort-Data: A9a23:gVi3661zhGib2aoZ6PbD5ftxkn2cJEfYwER7XKvMYLTBsI5bpzZTm
 zBKXWnSOa6MZTemKN4ibIni8E0Au5DXyINkGgNo3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yFjmE4E71btANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXV6
 bsen+WFYAX5g2MtajpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQglcxFOyS0HR2SMoUc243/JFLhg/W05FfWVSTe5dZFMB85aNhwFuZfWQmi9
 NQCIzwLKxuEne/zmev9Qeh3jcNlJ87uVG8dkig/lneCUrB3GtaaH/qiCdxwhF/cguhQFvbTf
 cwedBJkbQ/LZFtEPVJ/5JcWxr7y2CWkLWMCwL6TjYU+6UbKwA1J6ZG3a+L7Z+2aXOZ4uUnN8
 woq+EyiX0lFb4bAodafyVqom+TGhmX3VcQXHaez9v9Cj1iax2hVAxoTPXO95+Kyik+zQfpWN
 UlS9idGhawz8lG7C9z6UwC8rWWsoBERQZxTHvc85QXLzbDbizt1HUAeRTJHLdchrsJzHGVs3
 V6SlNSvDjtq2FGIdZ6D3u23nwu3E3YnFEgpfz8iEjkjwPLf/o5m23ojUe1fOKKyi9T0HxT5z
 DaLsDUyit0vYSgjif/TEbfv3WvEm3TZcjPZ8Dk7SY5M0++UTJSua4rt4l/B4LMZdcCST0KKu
 z4PnM32AAEy4XOlynLlrAYlRe3BCxO53Nv02gAH834JrGjFxpJbVdoMiAyS3W8wWir+RRfnY
 VXIpSRa74JJMX2hYMdfOt3oVp51nPS+Soi9Cpg4i+aihLAsJWdrGwkzNSatM5zFzyDAbIlmY
 MjLL5zwZZrkIf06kWLeqxghPU8DnX1mmjiJGvgXPjys0KGVYzaOWKwZPV6VJuE/5+Xsnekm2
 4g3Cid+8D0GCLeWSnCOqeY7dAlWRVBlXsqeg5IMKYa+zv9ORTtJ5wn5m+1xIuSIXs19y4/1w
 51KchMHkgSl2iOYeG1nqBlLMdvSYHq2llpjVQREALpi8yFLjVqHhEvHS6YKQA==
IronPort-HdrOrdr: A9a23:2uOLmKs//eQR/pectqxBeRMa7skDedV00zEX/kB9WHVpmwKj+/
 xG+85rtyMc5wx+ZJhNo7q90cq7MBDhHOBOgLX5VI3KNGLbUQCTQ72Kg7GO/9TIIVyaygck78
 ddm2wUMqyWMbC85vyKhDWFLw==
X-Talos-CUID: 9a23:TCjkP2NgiTD3pu5DAgpVzEs+RPIcVVbH3FGPEWmbIlo3R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AMiP6UgyZVY2IGj0rXyGGiFqU4DaaqIunAm4UnZQ?=
 =?us-ascii?q?+guDebhReJgaNlReaZYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="212643662"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 11:21:30 +0000
Received: from sjc-ads-1541.cisco.com (sjc-ads-1541.cisco.com [171.70.59.233])
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id 44ABLTuD031338;
	Fri, 10 May 2024 11:21:30 GMT
From: Valerii Chernous <vchernou@cisco.com>
To: linux-modules@vger.kernel.org
Cc: xe-linux-external@cisco.com, Nicolas Schier <n.schier@avm.de>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [MODALTS v0.1 4/4] add modules deps alternatives description
Date: Fri, 10 May 2024 04:21:28 -0700
Message-Id: <20240510112128.2417494-4-vchernou@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.59.233, sjc-ads-1541.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com

Cc: xe-linux-external@cisco.com
Cc: Valerii Chernous <vchernou@cisco.com>
Signed-off-by: Valerii Chernous <vchernou@cisco.com>
---
 README.deps.alternatives.txt | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 README.deps.alternatives.txt

diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.txt
new file mode 100644
index 0000000..9ad3ce5
--- /dev/null
+++ b/README.deps.alternatives.txt
@@ -0,0 +1,40 @@
+Modules alternatives feature allow to calculate dependency alternatives
+during build time and aviod to regenerate modules db into runtime
+
+To enable deps alternatives calculation use "-D" flag with depmod,
+it will create indexes modules.alternatives and modules.alternatives.bin
+This indexes will be used by modprobe in runtime
+By default modprobe will load first(primary/major) dependency from list
+If it required to load alternative module, it should be done manually before
+loading main modules set.
+For example systemd service that detect platform type can load required platform
+modules and after it run main device initialization
+In case when alternative module loaded, modprobe detect this and skip to load primary
+dependency
+
+modules deps alternatives generation basic algorithm description
+1. Load modules information(imported/exported symbols)
+2. Find depended symbol alternatives(create list available symbols
+   alternatives instead of storing last one)
+3. Choise primary/major alternative per depended symbol correspond to
+   build time dependency(build time deps getting from module info section)
+4. Create a list of dependency modules alternatives correspond to next rule:
+4.1 All modules alternatives for module dependency should provide all symbols
+    from primary/major dependency module
+5 Store modules alternatives index(modules.alternatives) as key:value where
+key is a pair depended#_#primary_depency,
+value is list of all modules that provide all symbols from primary_depency
+for depended module
+
+Note:
+Current implementation/algorithm doesn't cover variant where requred symbols
+from primary deps provided by more that one modules. Exporting all symbols in
+alternative depency that used by depended module from primary_depency is
+mandatory!
+
+Note:
+modules.dep index different for standard/basic and modules alternatives algorithms
+modules.dep for modules alternatives algorithm contain only direct dependencies and
+full dependency list will be calculated into runtime correspond to preferred alternative.
+modules.dep for standard/basic algorithm contain full dependency list for module and
+can't be changed during runtime without rebuild database via depmod
-- 
2.35.6

