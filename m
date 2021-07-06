Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E23AC07E96
	for <linux-modules@archiver.kernel.org>; Tue,  6 Jul 2021 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1340761C42
	for <linux-modules@archiver.kernel.org>; Tue,  6 Jul 2021 19:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGFTgw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:36:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45732 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229834AbhGFTgu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Jul 2021 15:36:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166JQ8ir012733;
        Tue, 6 Jul 2021 19:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=P5zjfSUYVo/ZhFSUpy2EXOtOtYQlM15FdV8WshTqZrY=;
 b=TBY+pA91nEmjssOqPUXjxQWICAMoWUjzhRTL1ZLa2BQd3FtcB2GbhagHllgBuPntmGCm
 OKax37zCsiwCR0TfLUPEmTca+gsgmrpzwUGyDfnIr5FjoCnYDeeCDKD0whjw5+aowBHW
 gWSdCZveCrMYyHiWtnMQHXLkJjNsXixHBNKxt4vQUayZSwZGUPzJIoZHydYBgL+LtDW6
 +QCB2ZzBQkG5GClcM0V9OOZCqAmXMhevawXt9T1SiGN2IexXjxHJMV46HtSXVfFgBBpq
 62/ddhxeOvYrmJ9lcGkU6scZfSYzwvCdm/QVphS7q8R3K7NVkykh3ObBoOyPgHAHtX4g MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8ebmyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 19:34:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 166JUHlH118929;
        Tue, 6 Jul 2021 19:34:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 39jfq9411r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 19:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5FAy1D/50YiSXodHqcWlgpq6xmsqy5MQcRaunrddqdHe1xe0FeK0Ap967zK9/ZR5Q7jN9bjWWyDiYFDz46AVGBZ/wTKkOEQkiTPhNEBLl4zNofL6IZ5g0kCerYE+ztz0KG845nex0pbZM4THtGfS4HDnTbam/tpg/vK3H9W5+p+mILGP3FNJ0eBYr+aiZ8tf7cZucBFiLg5qM9yon00u55Gj2HaiU1a5gBRCkihrdaz789qk8CxX/78F/MpZScfdVVCgeZMZr9fiFcVlYW9NflZYNvfDoNngej03OfNWywcaNqjyGgXCjfa1sRGL/r/tqhj+vqkL+G6D9mkTNEMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5zjfSUYVo/ZhFSUpy2EXOtOtYQlM15FdV8WshTqZrY=;
 b=B8FaOzANrtcDeMyh+x/72/NB5otu6Prgm2yZokgOL4O89SncEjeULWWBusrSac8OvNkGZbwBx2YPL7e61dk5XyeJvF63ONGT2xNFmIr3l5wE8HqnbuFmgOpt/+aeHkA2gO826gve4pXy3OTc1xlU1GIv7OwuF17DZjWqJR0SLOIYkh9xUrPo5wQ8bpwZclNz7u1n8m2M1vFI/I0cO/YmbXGxGUBgDdwQ6c3SyhumdZsb+c974h+Hc35wmEQ7veGvJmLUz62bRHeAtMObGqCF08+F7vgyPS/RahiWUeaTbk9kEDuLy7oYi08Nj94H6cTUiyE3DWPCoycFMMeC+uEm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5zjfSUYVo/ZhFSUpy2EXOtOtYQlM15FdV8WshTqZrY=;
 b=nFeocJL6AyOLnHudniN7SEvX0cvVnvMbeRpVo5Rod3Jvu+iTuj614zIYoZJs4+SaUcxUOY+ZamRmQ56bB5sKh7l3kiU/u8ISaHi3nkUZYwDS/rpQM1BSeiwsdUtWZXGkhTga8A+eUyB/WADyZveRcgNc7q2YHUsQmSPpET9u+s4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4617.namprd10.prod.outlook.com (2603:10b6:806:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.29; Tue, 6 Jul
 2021 19:33:57 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 19:33:57 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, Eugene Loh <eugene.loh@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: [PATCH v2 PING] kallsyms: new /proc/kallmodsyms with builtin modules and symbol sizes
Date:   Tue,  6 Jul 2021 20:33:34 +0100
Message-Id: <20210706193334.474270-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.32.0.255.gd9b1d14a2a
In-Reply-To: <20210629221542.93728-1-nick.alcock@oracle.com>
References: <20210629221542.93728-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:153::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 19:33:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4972e3d3-2d7b-4922-16a8-08d940b4ff1a
X-MS-TrafficTypeDiagnostic: SA2PR10MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB461788675C1C3CF4FB8C16608B1B9@SA2PR10MB4617.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CORHHgDhmOyxwJplojQUgaJW4PTbSY07rX2CgVDngAmpR0xmBgE95nl9sKEvrDVUFiMtmXowc0HVcQ/rOOx75xfhss5U+B8/BvtiiCkHUuDsPAmbjnenUDoopbEOVqHmRNWswZ9inkiceL22FPO1bd/GdqPlFmhyMDHmLiFYQnirWuHnLFg5r7K7gs8Cved9OFOhZgIQlszx9dSIE7lCbTYLRmV4eN21B9ffgkda6xeymbY9i3BHCxtzVCbq87qdVm8aptl+ScQ0QbFfHrfGVefA0RbWIWKmFmb1lVyyrUdYjOtc2yPD7XYp8hdSn8m+1TbWwqgUVi+nl9TGOYUDApNIgMSDkFDUXwR5vKnA/lEbjoSDgeOgo+D31rqu2HxS2yQdD7JXL1ncXhe9f00yJdLykfofg6DChur/o352JuTcp9Dhtjgc9G4+RRqSxsbJEsF5jsAg+h97iipucv8SUwdZK3VW1Hx2JwySv3VizRFNOxoJnyzDOKmUHAs3C8E5ds1ulwGxlbLxg23y1ePKsSXMwqV49WVOT/M4G7nWxLaFD7xLpqdB+EjqfE5XT2zY0/FbO5tHCoEgGRqxXx7cy9Ab0kQjfaHkMqc2AA4gfLvzxh633VaMCdGKER2DzPOYJnqFoWSv5tlRiz/U4+EeWdp7nzycdZTGRDQkEijaOtH0blIStZ9IAV8b0dlxz0o5YpsXL3iQ56noOJL3248NItQ6aUaiqETa0AdDFQz2Rko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(366004)(39860400002)(376002)(8676002)(6486002)(6512007)(1076003)(186003)(36756003)(44832011)(86362001)(8936002)(6506007)(30864003)(316002)(107886003)(5660300002)(4326008)(38100700002)(52116002)(54906003)(66556008)(2616005)(83380400001)(66946007)(6666004)(478600001)(66476007)(2906002)(2004002)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChW73hvz/f1Z/VMo8jJsUWOl6D/VK8n14tAt5rAE3uDaReaY2NxX+uuSiPgP?=
 =?us-ascii?Q?EmtwGsCNI7mcYrmJLTknPLYdno+ACAnsWjzdcWMPr2Nm7H9bYynMSFXQVcVp?=
 =?us-ascii?Q?OJXcOVDK9zyd2F3i+CCVoVVbTcVZaGPJU/KmKIjJ7eWO/Y2bCn4Gv+qNOL5p?=
 =?us-ascii?Q?0NG+3ccmVyBvdrly+5nqsKXPDBeOIOpCxlXtap5rorOfgd6CFup6aLaItZLM?=
 =?us-ascii?Q?6LJ/kUZOZFN7TpH675fGF39r/TnfnI6nEM/29V5T0wOe11PzOfyKl4HEfEHb?=
 =?us-ascii?Q?NN1bEF/XbEiMhdiuUelD108bRvx3kUuH+v1GxptgUFeKhlgh/c5sSv9TlRlT?=
 =?us-ascii?Q?RFzRQJimr6biqDS9CGu9npbo4C8YBQ9y/JLKbSPxe5doHRHtJLqyECighKGF?=
 =?us-ascii?Q?Ay39O/9EOP/c/ZxQrwdwFy92sxU511cO70sXvivM9SXw73KrmkpvLIA3gWZ7?=
 =?us-ascii?Q?QWh2s9YlmNNdrd+sfbXPDffAtTlPVMX0QHVgiin8Qb0wSytnjF6QFH80ZB57?=
 =?us-ascii?Q?e+Cqr/flZDFJcxu8DYfrfehdozH9+hA4BBBIbwAwEax+WcuXTeYV3o74+Rr7?=
 =?us-ascii?Q?CpPLDSzTDjDCJuXscWDSUygbLYyYi7KhjzCnuhV3JPAmqy3F7HD4Zw9t03C3?=
 =?us-ascii?Q?sqV9vlevbdZ8cGdWZkEWXqtFZC8DJXeZYsvHX7sgqhMdHUp1XuFyWCX6XYOA?=
 =?us-ascii?Q?C9dh9kE8Z2KHa414kT0RE7Bqw7y5Ua5MYxkG9YZ4xPZUdmkHzxPohFD3sC2a?=
 =?us-ascii?Q?G5n6+St48ETPbqDYKFmdfw9zE3XEQ3R/O63oC9q384M2+0XnluJ2sMTUE6N+?=
 =?us-ascii?Q?DRs47uADxMNqlNS6nAttw4eNA83M/YaqlmZVTOLZqI+wjWX92sKhw4/tKOXb?=
 =?us-ascii?Q?R//o2PzGkT+axjEVOzEFtCtl975An8HDwRU+y3FvfQEXahn1RqpXSf31SjRW?=
 =?us-ascii?Q?/TPpB710QJWIOhvkqjOyCzvI2FvpItqBV2tvmdfvNu79DbDKieNwQe6q9y/w?=
 =?us-ascii?Q?dlxVZ1z7gP4tzAhuDAY+da2kHM8fRu1zwJ59f4q/YXyq+ZtvOziV4rK2qE+i?=
 =?us-ascii?Q?yYrsNO7rhOF2J3a9mT/DjNJ2p3SEVmA+GlR6bNn706lrr6Ib1uStvuiUlOPL?=
 =?us-ascii?Q?xO/hdm8iotD5il6BejzxdNUtRix9xjAcGqTgFtt8QVmfWsBz8Ejwvsye/1le?=
 =?us-ascii?Q?eOi3SuP23A330ktIindjTdlF+0Aw3ALIURXIdLUaq07ujRu8LYXEROVZ7hBy?=
 =?us-ascii?Q?bIeD8VGg+UZVaj9Lc2Wa7wrqjSDd0u7Z50wdSZDoNZ7uHnFCgPvDfXbF8pPw?=
 =?us-ascii?Q?FMyvBpP5KsBypPCcGggJxDUy5yV0+4M3ByzgMNt+3tRmUg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4972e3d3-2d7b-4922-16a8-08d940b4ff1a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 19:33:57.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+7OKu5q6zGiLmHZRScHQuvJ3QqyGB0I2zwH9dAKVe+W/EdsWZsZ+JYHjf5vwu08pYdHzKztRwGjPsjiwcm/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4617
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060091
X-Proofpoint-GUID: AERUdf8xu9UAJK-I4mjCdrtc1f00XP5T
X-Proofpoint-ORIG-GUID: AERUdf8xu9UAJK-I4mjCdrtc1f00XP5T
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

/proc/kallsyms is very useful for tracers and other tools that need to
map kernel symbols to addresses.

It would be useful if:

- there were a mapping between kernel symbol and module name that only
  changed when the kernel source code is changed.  This mapping should
  not change simply because a module becomes built into the kernel.

- there were symbol size information to determine whether an address is
  within a symbol or outside it, especially given that there could be
  huge gaps between symbols.

Fix this by introducing a new config parameter CONFIG_KALLMODSYMS, which
does several things at once.

Change scripts/kallsyms.c stdin from "nm" to "nm -S" so that symbol
sizes are available.  Have sort_symbols() incorporate size info.  Emit
size info for each symbol into .kallsyms_sizes in the *.s output file.
Change module_get_kallsym() to return symbol size as well.

Generate a file "modules_thick.builtin" that maps from the thin archives
that make up built-in modules to their constituent object files.  (This
reintroduces the machinery that used to be used to generate
modules.builtin.  I am not wedded to this mechanism: if someone can
figure out a mechanism that does not require recursing over the entire
build tree, I'm happy to use it, but I suspect that no such mechanism
exists, since the only place the mapping from object file to module
exists is in the makefiles themselves. Regardless, this is fairly cheap,
adding less than a second to a typical hot-cache build of a large
enterprise kernel.  This is true even though it needs to be run
unconditionally whenever the .config changes.)

Generate a linker map ".tmp_vmlinux.map", converting it into
".tmp_vmlinux.ranges", mapping address ranges to object files.

Have scripts/kallsyms read these two new files to map symbol addresses
to built-in-module names and then write a mapping from object file
address to module name to the *.s output file.

The mapping consists of three new symbols:

 - .kallsyms_module_addresses/.kallsyms_module_offsets encodes the
   address/offset of each object file (derived from the linker map), in
   exactly the same way as .kallsyms_addresses/.kallsyms_offsets does
   for symbols.  There is no size: instead, the object files are
   assumed to tile the address space.  (This is slightly more
   space-efficient than using a size).  Non-text-section addresses are
   skipped: for now, all the users of this interface only need
   module/non-module information for instruction pointer addresses, not
   absolute-addressed symbols and the like.  This restriction can
   easily be lifted in future.  (For why this isn't called
   .kallsyms_objfiles, see two entries below.)

 - .kallsyms_module_names encodes the name of each module in a modified
   form of strtab: notably, if an object file appears in *multiple*
   modules, all of which are built in, this is encoded via a zero byte,
   a one-byte module count, then a series of that many null-terminated
   strings.  Object files which appear in only one module in such a
   multi-module list are redirected to point inside that list, so that
   modules which contain some object files shared with other modules
   and some object files exclusive to them do not double up the module
   name.  (There might still be some duplication between multiple
   multi-module lists, but this is an extremely marginal size effect,
   and resolving it would require an extra layer of lookup tables which
   would be even more complex, and incompressible to boot).  As a
   special case, the table starts with a single zero byte which does
   *not* represent the start of a multi-module list.

 - .kallsyms_modules connects the two, encoding a table associated 1:1
   with .kallsyms_module_addresses / kallsyms_module_offsets, pointing
   at an offset in .kallsyms_module_names describing which module (or
   modules, for a multi-module list) the code occupying this address
   range is part of.  If an address range is part of no module (always
   built-in) it points at 0 (the null byte at the start of the
   .kallsyms_module_anmes list).  Entries in this list that would
   contain the same value are fused together, along with their
   corresponding .kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in here do not really correspond to an object file, but more
   to some contiguous range of addresses which are guaranteed to belong
   to a single built-in module: so it seems best to call the symbols
   .kallsyms_modules*.  (The generator has a data structure that does
   correspond more closely to object files, from which .kallsyms_modules
   is generated, and that does use 'objfiles' terminology.)

In kernel/kallsyms, use the new symbol size information in
get_symbol_pos(), both to identify the correct symbol and to return
correct size information.  Emit a new /proc/kallmodsyms file akin to
/proc/kallsyms but with built-in-module names and symbol sizes, using a
new kallsyms_builtin_module_address() almost identical to
kallsyms_sym_address() to get the address corresponding to a given
.kallsyms_modules index, and a new get_builtin_module_idx quite similar
to get_symbol_pos to determine the index in the .kallsyms_modules array
that relates to a given address.  Save a little time by exploiting the
fact that all callers will only ever traverse this list from start to
end by allowing them to pass in the previous index returned from this
function as a hint: thus very few bsearches are actually needed.  (In
theory this could change to just walk straight down
kallsyms_module_addresses/offsets and not bother bsearching at all, but
doing it this way is hardly any slower and much more robust.)

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

The resulting /proc/kallmodsyms file looks like this:
    ffffffff8b013d20 409 t pt_buffer_setup_aux
    ffffffff8b014130 11f T intel_pt_interrupt
    ffffffff8b014250 2d T cpu_emergency_stop_pt
    ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
    ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
    ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
    ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
    ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
    ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]
This is emitted even if intel_rapl_perf is built into the kernel.

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 ab t handle_timestamp  [liquidio]
ffffffffa22b3b50 4a t free_netbuf       [liquidio]
ffffffffa22b3ba0 8d t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 b3 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 203 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 16b t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 1f t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 1f t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 d2 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 9c t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 11 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 11 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 2b t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 738 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 368 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 37 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 18 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 2e t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 69 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 92 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 175 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 ab t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 4a t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 2b t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 7e t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

Those symbols that come from object files that are genuinely reused and
that appear only once in meory get a /proc/kallmodsyms line with
[multiple] [modules] on it: consumers will have to be ready to handle
such lines.

Also, kernel symbols for built-in modules will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero; symbol sizes are treated similarly.

The size impact of all of this is minimal: for the case above, the
kallsyms2.S file went from 14107772 to 14137245 bytes, a gain of 29743
bytes, or 0.16%: vmlinux gained 10824 bytes, a gain of .017%, and the
compressed vmlinux only 7552 bytes, a gain of .08%: though the latter
two values are very configuration-dependent, they seem likely to scale
roughly with the kernel they are part of.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---
 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Makefile                    |  21 +-
 include/linux/module.h      |   7 +-
 init/Kconfig                |   8 +
 kernel/kallsyms.c           | 304 ++++++++++++++---
 kernel/module.c             |   4 +-
 scripts/Kbuild.include      |   6 +
 scripts/Makefile            |   6 +
 scripts/Makefile.modbuiltin |  56 ++++
 scripts/kallsyms.c          | 650 +++++++++++++++++++++++++++++++++++-
 scripts/kconfig/confdata.c  |  41 ++-
 scripts/link-vmlinux.sh     |  23 +-
 scripts/modules_thick.c     | 200 +++++++++++
 scripts/modules_thick.h     |  48 +++
 15 files changed, 1309 insertions(+), 67 deletions(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

Differences from v1, a year or so back:

 - Move from a straight symbol->module name mapping to a mapping from
   address-range to TU to module name list, bringing major space savings
   over the previous approach and support for object files used by many
   built-in modules at the same time, at the cost of a slightly more complex
   approach (unavoidably so, I think, given that we have to merge three data
   sources together: the link map in .tmp_vmlinux.ranges, the nm output on
   stdin, and the mapping from TU name to module names in
   modules_thick.builtin).

   We do opportunistic merging of TUs if they cite the same modules and
   reuse module names where doing so is simple: see optimize_obj2mod
   below. I considered more extensive searches for mergeable entries and
   more intricate encodings of the module name list allowing TUs that are
   used by overlapping sets of modules to share their names, but such
   modules are rare enough (and such overlapping sharings are vanishingly
   rare) that it seemed likely to save only a few bytes at the cost of much
   more hard-to-test code. This is doubly true now that the tables needed
   are only a few kilobytes in length.

I am not wedded to using a separate /proc/kallmodsyms file for this, nor to
a config option, nor to the notation for [built-in] [modules]: one I
considered was to put them all in /proc/kallsyms, and use {curly} {braces}
for built-in modules. My worry there was that I didn't know how many
programs this would break, nor how to introduce the size field without
breaking literally everyone. At least using a new file is guaranteed safe.
The size overhead of this is low enough now that dropping the separate
config option might be more acceptable, I suppose...

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..b49cd96f587a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 *.zst
 Module.symvers
 modules.order
+modules_thick.builtin
 
 #
 # Top-level generic files
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 910b30a2a7d9..6a78988547d0 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -183,6 +183,7 @@ modules.builtin
 modules.builtin.modinfo
 modules.nsdeps
 modules.order
+modules_thick.builtin
 modversions.h*
 nconf
 nconf-cfg
diff --git a/Makefile b/Makefile
index 0565caea0362..bbd0b13a8f0b 100644
--- a/Makefile
+++ b/Makefile
@@ -1195,7 +1195,7 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
+vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) modules_thick.builtin FORCE
 	+$(call if_changed_dep,link-vmlinux)
 
 targets := vmlinux
@@ -1496,6 +1496,23 @@ __modinst_pre:
 
 endif # CONFIG_MODULES
 
+# modules_thick.builtin maps from kernel modules (or rather the object file
+# names they would have had had they not been built in) to their constituent
+# object files: we can use this to determine which modules any given object
+# file is part of.  (We cannot eliminate the slight redundancy here without
+# double-expansion.)
+
+modthickbuiltin-files := $(addsuffix /modules_thick.builtin, $(build-dirs))
+
+modules_thick.builtin: $(modthickbuiltin-files)
+	$(Q)$(AWK) '!x[$$0]++' $(addsuffix /$@, $(build-dirs)) > $@
+
+# tristate.conf is not included from this Makefile. Add it as a prerequisite
+# here to make it self-healing in case somebody accidentally removes it.
+$(modthickbuiltin-files): include/config/tristate.conf
+	$(Q)$(MAKE) $(modbuiltin)=$(patsubst %/modules_thick.builtin,%,$@) builtin-file=modules_thick.builtin
+
+
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1865,7 +1882,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/include/linux/module.h b/include/linux/module.h
index 8100bb477d86..8b5d1a7f6d9e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -579,7 +579,8 @@ struct module *find_module(const char *name);
 /* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
    symnum out of range. */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported);
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
@@ -756,8 +757,8 @@ static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *
 }
 
 static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
-					char *type, char *name,
-					char *module_name, int *exported)
+				     char *type, char *name, char *module_name,
+				     unsigned long *size, int *exported)
 {
 	return -ERANGE;
 }
diff --git a/init/Kconfig b/init/Kconfig
index a61c92066c2e..1044b00b8361 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1495,6 +1495,14 @@ config POSIX_TIMERS
 
 	  If unsure say y.
 
+config KALLMODSYMS
+	default y
+	bool "Enable support for /proc/kallmodsyms" if EXPERT
+	depends on KALLSYMS
+	help
+	  This option enables the /proc/kallmodsyms file, which maps symbols
+	  to addresses and their associated modules.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index c851ca0ed357..7cab409b7d28 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -33,6 +33,7 @@
  */
 extern const unsigned long kallsyms_addresses[] __weak;
 extern const int kallsyms_offsets[] __weak;
+extern const unsigned long kallsyms_sizes[] __weak;
 extern const u8 kallsyms_names[] __weak;
 
 /*
@@ -45,8 +46,18 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_module_names_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const char kallsyms_module_names[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
@@ -182,6 +193,25 @@ static inline bool cleanup_symbol_name(char *s)
 static inline bool cleanup_symbol_name(char *s) { return false; }
 #endif
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -225,12 +255,24 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+/*
+ * The caller passes in an address, and we return an index to the symbol --
+ * potentially also size and offset information.
+ * But an address might map to multiple symbols because:
+ *   - some symbols might have zero size
+ *   - some symbols might be aliases of one another
+ *   - some symbols might span (encompass) others
+ * The symbols should already be ordered so that, for a particular address,
+ * we first have the zero-size ones, then the biggest, then the smallest.
+ * So we find the index by:
+ *   - finding the last symbol with the target address
+ *   - backing the index up so long as both the address and size are unchanged
+ */
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
 				    unsigned long *offset)
 {
-	unsigned long symbol_start = 0, symbol_end = 0;
-	unsigned long i, low, high, mid;
+	unsigned long low, high, mid;
 
 	/* This kernel should never had been booted. */
 	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
@@ -251,40 +293,69 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	}
 
 	/*
-	 * Search for the first aliased symbol. Aliased
-	 * symbols are symbols with the same address.
+	 * Search for the first aliased symbol.
 	 */
-	while (low && kallsyms_sym_address(low-1) == kallsyms_sym_address(low))
+	while (low
+	    && kallsyms_sym_address(low-1) == kallsyms_sym_address(low)
+	    && kallsyms_sizes[low-1] == kallsyms_sizes[low])
 		--low;
 
-	symbol_start = kallsyms_sym_address(low);
-
-	/* Search for next non-aliased symbol. */
-	for (i = low + 1; i < kallsyms_num_syms; i++) {
-		if (kallsyms_sym_address(i) > symbol_start) {
-			symbol_end = kallsyms_sym_address(i);
-			break;
-		}
-	}
-
-	/* If we found no next symbol, we use the end of the section. */
-	if (!symbol_end) {
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
-			symbol_end = (unsigned long)_end;
-		else
-			symbol_end = (unsigned long)_etext;
-	}
-
 	if (symbolsize)
-		*symbolsize = symbol_end - symbol_start;
+		*symbolsize = kallsyms_sizes[low];
 	if (offset)
-		*offset = addr - symbol_start;
+		*offset = addr - kallsyms_sym_address(low);
 
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules, or (unsigned long) -1 if none
+ * match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_module_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -300,6 +371,7 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
+EXPORT_SYMBOL_GPL(kallsyms_lookup_size_offset);
 
 /*
  * Lookup an address
@@ -492,9 +564,12 @@ struct kallsym_iter {
 	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
+	unsigned long size;
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	unsigned long hint_builtin_module_idx;
 	int exported;
 	int show_value;
 };
@@ -524,7 +599,9 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
-				     &iter->exported);
+				     &iter->size, &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -544,6 +621,8 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -558,6 +637,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -578,23 +658,53 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
+	unsigned long mod_idx;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
+	iter->size = kallsyms_sizes[iter->pos];
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		if (kallsyms_module_offsets)
+			mod_idx =
+			  get_builtin_module_idx(iter->value,
+						 iter->hint_builtin_module_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings) and module names are known,
+		 * and if the address was found there, and if the corresponding
+		 * module index is nonzero.  All other cases mean off the end of
+		 * the binary or in a non-modular range in between one or more
+		 * modules.  (Also guard against a corrupt kallsyms_objfiles
+		 * array pointing off the end of kallsyms_modules.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_module_names != NULL &&
+		    mod_idx != (unsigned long) -1 &&
+		    kallsyms_modules[mod_idx] != 0 &&
+		    kallsyms_modules[mod_idx] < kallsyms_module_names_len)
+			iter->builtin_module_names =
+			  &kallsyms_module_names[kallsyms_modules[mod_idx]];
+		iter->hint_builtin_module_idx = mod_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -640,7 +750,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -650,7 +760,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -660,14 +770,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -676,34 +786,86 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
+	unsigned long size;
 
 	/* Some debugging symbols have no name.  Ignore them. */
 	if (!iter->name[0])
 		return 0;
 
 	value = iter->show_value ? (void *)iter->value : NULL;
+	size = iter->show_value ? iter->size : 0;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
-	} else
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %lx %c %s\t[%s]", value,
+					   size, type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf (m, " [%s]", walk);
+				}
+				seq_printf(m, "\n");
+			}
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
+	/*
+	 * Non-modular, /proc/kallmodsyms -> print size.
+	 */
+	} else if (kallmodsyms)
+		seq_printf(m, "%px %lx %c %s\n", value, size,
+			   iter->type, iter->name);
+	else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -711,6 +873,35 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -746,7 +937,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -754,7 +946,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -767,6 +959,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -777,7 +981,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -794,9 +998,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
diff --git a/kernel/module.c b/kernel/module.c
index 927d46cb8eb9..0229d91241d1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4332,7 +4332,8 @@ int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
 }
 
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported)
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported)
 {
 	struct module *mod;
 
@@ -4351,6 +4352,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
+			*size = kallsyms->symtab[symnum].st_size;
 			preempt_enable();
 			return 0;
 		}
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 82dd1b65b7a8..b8cc96cd8a9d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -73,6 +73,12 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
+###
+# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
+# Usage:
+# $(Q)$(MAKE) $(modbuiltin)=dir
+modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
diff --git a/scripts/Makefile b/scripts/Makefile
index 9adb6d247818..d677995d3f31 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -32,6 +32,12 @@ HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
 HOSTLDLIBS_sorttable = -lpthread
 endif
 
+kallsyms-objs  := kallsyms.o
+
+ifdef CONFIG_KALLMODSYMS
+kallsyms-objs += modules_thick.o
+endif
+
 # The following programs are only built on demand
 hostprogs += unifdef
 
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
new file mode 100644
index 000000000000..a27b692ea795
--- /dev/null
+++ b/scripts/Makefile.modbuiltin
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Generating modules_thick.builtin
+# ==========================================================================
+
+src := $(obj)
+
+PHONY := __modbuiltin
+__modbuiltin:
+
+include include/config/auto.conf
+# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
+# That way, we get the list of built-in modules in obj-Y
+include include/config/tristate.conf
+
+include scripts/Kbuild.include
+
+ifdef building_out_of_srctree
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+endif
+
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
+include $(kbuild-file)
+
+include scripts/Makefile.lib
+
+modthickbuiltin-subdirs := $(patsubst %,%/modules_thick.builtin, $(subdir-ym))
+modthickbuiltin-target  := $(obj)/modules_thick.builtin
+
+__modbuiltin: $(obj)/$(builtin-file) $(subdir-ym)
+	@:
+
+$(modthickbuiltin-target): $(subdir-ym) FORCE
+	$(Q) rm -f $@
+	$(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
+		printf "%s:" $(addprefix $(obj)/,$(mod-o)) >> $@; \
+		printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
+			$($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
+		printf "\n" >> $@; ) \
+	cat /dev/null $(modthickbuiltin-subdirs) >> $@;
+
+PHONY += FORCE
+
+FORCE:
+
+# Descending
+# ---------------------------------------------------------------------------
+
+PHONY += $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) $(modbuiltin)=$@ builtin-file=$(builtin-file)
+
+.PHONY: $(PHONY)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 54ad86d13784..c134a05042cf 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,10 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: nm -n -S vmlinux
+ *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
+ *             [--base-relative] [--builtin=modules_thick.builtin]
+ *        > symbols.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -18,19 +21,31 @@
  *
  */
 
+#define _GNU_SOURCE 1
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
 #include <limits.h>
+#include <assert.h>
+#include "modules_thick.h"
 
+#include "../include/generated/autoconf.h"
+
+#ifdef CONFIG_KALLMODSYMS
+#include <errno.h>
+#endif
+
+#ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+#endif
 
 #define KSYM_NAME_LEN		128
 
 struct sym_entry {
 	unsigned long long addr;
+	unsigned long long size;
 	unsigned int len;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
@@ -67,11 +82,304 @@ static int token_profit[0x10000];
 static unsigned char best_table[256][2];
 static unsigned char best_table_len[256];
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned int strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+
+	for (; *s; s++)
+		hash = (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+static unsigned int memhash(char *s, size_t len)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hash = (hash ^ *(s + i)) * 0x01000193;
+	return hash;
+}
+
+#define OBJ2MOD_BITS 10
+#define OBJ2MOD_N (1 << OBJ2MOD_BITS)
+#define OBJ2MOD_MASK (OBJ2MOD_N - 1)
+struct obj2mod_elem {
+	char *obj;
+	char *mods;			/* sorted module name strtab */
+	size_t nmods;			/* number of modules in "mods" */
+	size_t mods_size;		/* size of all mods together */
+	int mod_offset;			/* offset in .kallsyms_module_names */
+	/*
+	 * If set at emission time, this points at another obj2mod entry that
+	 * contains the module name we need (possibly at a slightly later
+	 * offset, if the entry is for an objfile that appears in many modules).
+	 */
+	struct obj2mod_elem *xref;
+	struct obj2mod_elem *obj2mod_next;
+	struct obj2mod_elem *mod2obj_next;
+};
+
+/*
+ * Map from object files to obj2mod entries (a unique mapping), and vice versa
+ * (not unique, but entries for objfiles in more than one module in this hash
+ * are ignored).
+ */
+
+static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
+static size_t num_objfiles;
+
+/*
+ * An ordered list of address ranges and the objfile that occupies that range.
+ */
+struct addrmap_entry {
+	unsigned long long addr;
+	struct obj2mod_elem *objfile;
+};
+static struct addrmap_entry *addrmap;
+static int addrmap_num, addrmap_alloced;
+
+static void obj2mod_init(void)
+{
+	memset(obj2mod, 0, sizeof(obj2mod));
+}
+
+static struct obj2mod_elem *obj2mod_get(const char *obj)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+		if (strcmp(elem->obj, obj) == 0)
+			return elem;
+	}
+	return NULL;
+}
+
+/*
+ * Note that a given object file is found in some module, interning it in the
+ * obj2mod hash.  Should not be called more than once for any given (module,
+ * object) pair.
+ */
+static void obj2mod_add(char *obj, char *mod)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	elem = obj2mod_get(obj);
+	if (!elem) {
+		int j = strhash(mod) & OBJ2MOD_MASK;
+
+		elem = malloc(sizeof(struct obj2mod_elem));
+		if (!elem)
+			goto oom;
+		memset(elem, 0, sizeof(struct obj2mod_elem));
+		elem->obj = strdup(obj);
+		if (!elem->obj)
+			goto oom;
+		elem->mods = strdup(mod);
+		if (!elem->mods)
+			goto oom;
+
+		elem->obj2mod_next = obj2mod[i];
+		obj2mod[i] = elem;
+		elem->mod2obj_next = mod2obj[j];
+		mod2obj[j] = elem;
+		num_objfiles++;
+	} else {
+		/*
+		 * TU appears in multiple modules.  mod2obj for this entry will
+		 * be ignored from now on, except insofar as it is needed to
+		 * maintain the hash chain.
+		 */
+		elem->mods = realloc(elem->mods, elem->mods_size +
+				     strlen(mod) + 1);
+		if (!elem->mods)
+			goto oom;
+		strcpy(elem->mods + elem->mods_size, mod);
+	}
+
+	elem->mods_size += strlen(mod) + 1;
+	elem->nmods++;
+	if (elem->nmods > 255) {
+		fprintf(stderr, "kallsyms: %s: too many modules associated with this object file\n",
+			obj);
+		exit(EXIT_FAILURE);
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+
+/*
+ * Used inside optimize_obj2mod to identify duplicate module entries.
+ */
+struct obj2mod_modhash_elem {
+	struct obj2mod_elem *elem;
+	unsigned int modhash;		/* hash value of this entry */
+};
+
+static int qstrcmp(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
+static int qmodhash(const void *a, const void *b)
+{
+	const struct obj2mod_modhash_elem *el_a = a;
+	const struct obj2mod_modhash_elem *el_b = b;
+	if (el_a->modhash < el_b->modhash)
+		return -1;
+	else if (el_a->modhash > el_b->modhash)
+		return 1;
+	return 0;
+}
+
+/*
+ * Associate all TUs in obj2mod which refer to the same module with a single
+ * obj2mod entry for emission, preferring to point into the module list in a
+ * multi-module objfile.
+ */
+static void optimize_obj2mod(void)
+{
+	size_t i;
+	size_t n = 0;
+	struct obj2mod_elem *elem;
+	struct obj2mod_elem *dedup;
+	/* An array of all obj2mod_elems, later sorted by hashval.  */
+	struct obj2mod_modhash_elem *uniq;
+	struct obj2mod_modhash_elem *last;
+
+	/*
+	 * Canonicalize all module lists by sorting them, then compute their
+	 * hash values.
+	 */
+	uniq = malloc(sizeof(struct obj2mod_modhash_elem) * num_objfiles);
+	if (uniq == NULL)
+		goto oom;
+
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+			if (elem->nmods >= 2) {
+				char **sorter;
+				char *walk;
+				char *tmp_mods;
+				size_t j;
+
+				tmp_mods = malloc(elem->mods_size);
+				sorter = malloc(sizeof(char *) * elem->nmods);
+				if (sorter == NULL || tmp_mods == NULL)
+					goto oom;
+				memcpy(tmp_mods, elem->mods, elem->mods_size);
+
+				for (j = 0, walk = tmp_mods; j < elem->nmods;
+				     j++) {
+					sorter[j] = walk;
+					walk += strlen(walk) + 1;
+				}
+				qsort(sorter, elem->nmods, sizeof (char *),
+				      qstrcmp);
+				for (j = 0, walk = elem->mods; j < elem->nmods;
+				     j++) {
+					strcpy(walk, sorter[j]);
+					walk += strlen(walk) + 1;
+				}
+				free(tmp_mods);
+				free(sorter);
+			}
+
+			uniq[n].elem = elem;
+			uniq[n].modhash = memhash(elem->mods, elem->mods_size);
+			n++;
+		}
+	}
+
+	qsort (uniq, num_objfiles, sizeof (struct obj2mod_modhash_elem),
+	       qmodhash);
+
+	/*
+	 * Work over multimodule entries.  These must be emitted into
+	 * .kallsyms_module_names as a unit, but we can still optimize by
+	 * reusing some other identical entry.  Single-file modules are amenable
+	 * to the same optimization, but we avoid doing it for now so that we
+	 * can prefer to point them directly inside a multimodule entry.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		const char *onemod;
+		size_t j;
+
+		if (uniq[i].elem->nmods < 2)
+			continue;
+
+		/* Duplicate multimodule.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			continue;
+		}
+
+		/*
+		 * Single-module entries relating to modules also emitted as
+		 * part of this multimodule entry can refer to it: later, we
+		 * will hunt down the right specific module name within this
+		 * multimodule entry and point directly to it.
+		 */
+		onemod = uniq[i].elem->mods;
+		for (j = uniq[i].elem->nmods; j > 0; j--) {
+			int h = strhash(onemod) & OBJ2MOD_MASK;
+
+			for (dedup = mod2obj[h]; dedup;
+			     dedup = dedup->mod2obj_next) {
+				if (dedup->nmods > 1)
+					continue;
+
+				if (strcmp(dedup->mods, onemod) != 0)
+					continue;
+				dedup->xref = uniq[i].elem;
+				assert (uniq[i].elem->xref == NULL);
+			}
+			onemod += strlen(onemod) + 1;
+		}
+
+		last = &uniq[i];
+	}
+
+	/*
+	 * Now traverse all single-module entries, xreffing every one that
+	 * relates to a given module to the first one we saw that refers to that
+	 * module.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		if (uniq[i].elem->nmods > 1)
+			continue;
+
+		if (uniq[i].elem->xref != NULL)
+			continue;
+
+		/* Duplicate module name.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			assert (last->elem->xref == NULL);
+			continue;
+		}
+		last = &uniq[i];
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
+	exit(EXIT_FAILURE);
+}
+#endif
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
-			"[--base-relative] < in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
+			"[--base-relative] [--builtin=modules_thick.builtin] "
+			"< nm_vmlinux.out > symbols.S\n");
 	exit(1);
 }
 
@@ -94,11 +402,18 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_addresses",
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
+		"kallsyms_sizes",
 		"kallsyms_num_syms",
+		"kallsyms_num_modules",
 		"kallsyms_names",
 		"kallsyms_markers",
 		"kallsyms_token_table",
 		"kallsyms_token_index",
+		"kallsyms_module_offsets",
+		"kallsyms_module_addresses",
+		"kallsyms_modules",
+		"kallsyms_module_names",
+		"kallsyms_module_names_len",
 		/* Exclude linker generated symbols which vary between passes */
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */
@@ -201,10 +516,11 @@ static struct sym_entry *read_symbol(FILE *in)
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
-	int rc;
+	int rc = 0;
+	unsigned long long size;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
-	if (rc != 3) {
+	rc = fscanf(in, "%llx %llx %c %499s\n", &addr, &size, &type, name);
+	if (rc != 4) {
 		if (rc != EOF && fgets(name, 500, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
@@ -242,12 +558,13 @@ static struct sym_entry *read_symbol(FILE *in)
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
 	sym->percpu_absolute = 0;
+	sym->size = size;
 
 	return sym;
 }
 
-static int symbol_in_range(const struct sym_entry *s,
-			   const struct addr_range *ranges, int entries)
+static int addr_in_range(unsigned long long addr,
+			 const struct addr_range *ranges, int entries)
 {
 	size_t i;
 	const struct addr_range *ar;
@@ -255,7 +572,7 @@ static int symbol_in_range(const struct sym_entry *s,
 	for (i = 0; i < entries; ++i) {
 		ar = &ranges[i];
 
-		if (s->addr >= ar->start && s->addr <= ar->end)
+		if (addr >= ar->start && addr <= ar->end)
 			return 1;
 	}
 
@@ -269,8 +586,8 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
-		if (symbol_in_range(s, text_ranges,
-				    ARRAY_SIZE(text_ranges)) == 0)
+		if (addr_in_range(s->addr, text_ranges,
+				  ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
 		/* Corner case.  Discard any symbols with the same value as
 		 * _etext _einittext; they can move between pass 1 and 2 when
@@ -352,6 +669,181 @@ static void output_address(unsigned long long addr)
 		printf("\tPTR\t_text - %#llx\n", _text - addr);
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/* Output the .kallmodsyms_modules symbol content. */
+static void output_kallmodsyms_modules(void)
+{
+	struct obj2mod_elem *elem;
+	size_t offset = 1;
+	size_t i;
+
+	/*
+	 * Traverse and emit, chasing xref and updating mod_offset accordingly.
+	 * Emit a single \0 at the start, to encode non-modular objfiles.
+	 */
+	output_label("kallsyms_module_names");
+	printf("\t.byte\t0\n");
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem;
+		     elem = elem->obj2mod_next) {
+			const char *onemod;
+			size_t i;
+			struct obj2mod_elem *out_elem = elem;
+
+			if (elem->xref)
+				out_elem = elem->xref;
+			if (out_elem->mod_offset != 0)
+				continue;	/* Already emitted.  */
+
+			out_elem->mod_offset = offset;
+			onemod = out_elem->mods;
+
+			/*
+			 * Technically this is a waste of space: we could just
+			 * as well implement multimodule entries by pointing one
+			 * byte further back, to the trailing \0 of the previous
+			 * entry, but doing it this way makes it more obvious
+			 * when an entry is a multimodule entry.
+			 */
+			if (out_elem->nmods != 1) {
+				printf("\t.byte\t0\n");
+				printf("\t.byte\t%zi\n", out_elem->nmods);
+				offset += 2;
+			}
+
+			for (i = out_elem->nmods; i > 0; i--) {
+				printf("\t.asciz\t\"%s\"\n", onemod);
+				offset += strlen(onemod) + 1;
+				onemod += strlen(onemod) + 1;
+			}
+		}
+	}
+	printf("\n");
+	output_label("kallsyms_module_names_len");
+	printf("\t.long\t%zi\n", offset);
+}
+
+static void output_kallmodsyms_objfiles(void)
+{
+	size_t i = 0;
+	size_t emitted_offsets = 0;
+	size_t emitted_objfiles = 0;
+
+	if (base_relative)
+		output_label("kallsyms_module_offsets");
+	else
+		output_label("kallsyms_module_addresses");
+
+	for (i = 0; i < addrmap_num; i++) {
+		long long offset;
+		int overflow;
+
+                /*
+                 * Fuse consecutive address ranges citing the same object file
+                 * into one.
+                 */
+                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+                        continue;
+
+		if (base_relative) {
+			if (!absolute_percpu) {
+				offset = addrmap[i].addr - relative_base;
+				overflow = (offset < 0 || offset > UINT_MAX);
+			} else {
+				offset = relative_base - addrmap[i].addr - 1;
+				overflow = (offset < INT_MIN || offset >= 0);
+			}
+			if (overflow) {
+				fprintf(stderr, "kallsyms failure: "
+					"objfile %s at address %#llx out of range in relative mode\n",
+					addrmap[i].objfile ? addrmap[i].objfile->obj :
+					"in always-built-in object", table[i]->addr);
+				exit(EXIT_FAILURE);
+			}
+			printf("\t.long\t0x%x\n", (int)offset);
+		} else
+			printf("\tPTR\t%#llx\n", addrmap[i].addr);
+		emitted_offsets++;
+	}
+
+	output_label("kallsyms_modules");
+
+	for (i = 0; i < addrmap_num; i++) {
+		struct obj2mod_elem *elem = addrmap[i].objfile;
+		int orig_nmods;
+		const char *orig_modname;
+		int mod_offset;
+
+		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+			continue;
+
+		/*
+		 * Address range cites no object file: point at 0, the built-in
+		 * module.
+		 */
+		if (addrmap[i].objfile == NULL) {
+			printf("\t.long\t0x0\n");
+			emitted_objfiles++;
+			continue;
+		}
+
+		orig_nmods = elem->nmods;
+		orig_modname = elem->mods;
+
+		/*
+		 * Chase down xrefs, if need be.  There can only be one layer of
+		 * these: from single-module entry to other single-module entry,
+		 * or from single- or multi-module entry to another multi-module
+		 * entry.  Single -> single and multi -> multi always points at
+		 * the start of the xref target, so its offset can be used as is.
+		 */ 
+		if (elem->xref)
+			elem = elem->xref;
+
+		if (elem->nmods == 1 || orig_nmods > 1)
+			mod_offset = elem->mod_offset;
+		else {
+			/*
+			 * If this is a reference from a single-module entry to
+			 * a multi-module entry, hunt down the offset to this
+			 * specific module's name (which is guaranteed to be
+			 * present: see optimize_obj2mod).
+			 */
+
+			size_t j = elem->nmods;
+			const char *onemod = elem->mods;
+			mod_offset = elem->mod_offset;
+
+			for (; j > 0; j--) {
+				if (strcmp(orig_modname, onemod) == 0)
+					break;
+				onemod += strlen(onemod) + 1;
+			}
+			assert (j > 0);
+			/*
+			 * +2 to skip the null byte and count at the start of
+			 * the multimodule entry.
+			 */
+			mod_offset += onemod - elem->mods + 2;
+		}
+
+		/*
+		 * Zero offset is the initial \0, there to catch uninitialized
+		 * obj2mod entries, and is forbidden.
+		 */
+		assert (mod_offset != 0);
+
+		printf("\t.long\t0x%x\n", mod_offset);
+		emitted_objfiles++;
+	}
+
+	assert (emitted_offsets == emitted_objfiles);
+	output_label("kallsyms_num_modules");
+	printf("\t.long\t%zi\n", emitted_objfiles);
+	printf("\n");
+}
+#endif /* CONFIG_KALLMODSYMS */
+
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(const unsigned char *data, int len, char *result)
@@ -451,6 +943,16 @@ static void write_src(void)
 		printf("\n");
 	}
 
+	output_label("kallsyms_sizes");
+	for (i = 0; i < table_cnt; i++)
+		printf("\tPTR\t%#llx\n", table[i]->size);
+	printf("\n");
+
+#ifdef CONFIG_KALLMODSYMS
+	output_kallmodsyms_modules();
+	output_kallmodsyms_objfiles();
+#endif
+
 	output_label("kallsyms_num_syms");
 	printf("\t.long\t%u\n", table_cnt);
 	printf("\n");
@@ -502,7 +1004,6 @@ static void write_src(void)
 	printf("\n");
 }
 
-
 /* table lookup compression functions */
 
 /* count all the possible tokens in a symbol */
@@ -703,6 +1204,18 @@ static int compare_symbols(const void *a, const void *b)
 	if (sa->addr < sb->addr)
 		return -1;
 
+	/* zero-size markers before nonzero-size symbols */
+	if (sa->size > 0 && sb->size == 0)
+		return 1;
+	if (sa->size == 0 && sb->size > 0)
+		return -1;
+
+	/* sort by size (large size preceding symbols it encompasses) */
+	if (sa->size < sb->size)
+		return 1;
+	if (sa->size > sb->size)
+		return -1;
+
 	/* sort by "weakness" type */
 	wa = (sa->sym[0] == 'w') || (sa->sym[0] == 'W');
 	wb = (sb->sym[0] == 'w') || (sb->sym[0] == 'W');
@@ -735,7 +1248,7 @@ static void make_percpus_absolute(void)
 	unsigned int i;
 
 	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
+		if (addr_in_range(table[i]->addr, &percpu_range, 1)) {
 			/*
 			 * Keep the 'A' override for percpu symbols to
 			 * ensure consistent behavior compared to older
@@ -762,17 +1275,125 @@ static void record_relative_base(void)
 		}
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/*
+ * Read the linker map.
+ */
+static void read_linker_map(void)
+{
+	unsigned long long addr, size;
+	char obj[PATH_MAX+1];
+	FILE *f = fopen(".tmp_vmlinux.ranges", "r");
+
+	if (!f) {
+		fprintf(stderr, "Cannot open '.tmp_vmlinux.ranges'.\n");
+		exit(1);
+	}
+
+	addrmap_num = 0;
+	addrmap_alloced = 4096;
+	addrmap = malloc(sizeof(*addrmap) * addrmap_alloced);
+	if (!addrmap)
+		goto oom;
+
+	/*
+	 * For each address range, add to addrmap the address and the objfile
+	 * entry to which the range maps.  Only add entries relating to text
+	 * ranges.  (We assume that the text ranges are tightly packed, because
+	 * in any reasonable object file format they will be, so we can ignore
+	 * the size.)
+	 *
+	 * Ranges that do not correspond to a built-in module, but to an
+	 * always-built-in object file, have no obj2mod_elem and point at NULL
+	 * instead.
+	 */
+
+	while (fscanf(f, "%llx %llx %s\n", &addr, &size, obj) == 3) {
+		struct obj2mod_elem *elem = obj2mod_get(obj);
+
+		if (addr == 0 || size == 0 ||
+		    !addr_in_range(addr, text_ranges, ARRAY_SIZE(text_ranges)))
+			continue;
+
+		if (addrmap_num >= addrmap_alloced) {
+			addrmap_alloced *= 2;
+			addrmap = realloc(addrmap,
+			    sizeof(*addrmap) * addrmap_alloced);
+			if (!addrmap)
+				goto oom;
+		}
+
+                addrmap[addrmap_num].addr = addr;
+                addrmap[addrmap_num].objfile = elem;
+		addrmap_num++;
+	}
+	fclose(f);
+	return;
+
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+
+/*
+ * Read "modules_thick.builtin" (the list of built-in modules).  Construct the
+ * obj2mod hash to track objfile -> module mappings.  Read ".tmp_vmlinux.ranges"
+ * (the linker map) and build addrmap[], which maps address ranges to built-in
+ * module names (using obj2mod).
+ */
+static void read_modules(const char *modules_builtin)
+{
+	struct modules_thick_iter *i;
+	char *module_name = NULL;
+	char **module_paths;
+
+	obj2mod_init();
+	/*
+	 * Iterate over all modules in modules_thick.builtin and add each.
+	 */
+	i = modules_thick_iter_new(modules_builtin);
+	if (i == NULL) {
+		fprintf(stderr, "Cannot iterate over builtin modules.\n");
+		exit(1);
+	}
+
+	while ((module_paths = modules_thick_iter_next(i, &module_name))) {
+		char **walk = module_paths;
+		while (*walk) {
+			obj2mod_add(*walk, module_name);
+			walk++;
+		}
+		free(module_paths);
+	}
+
+	free(module_name);
+	modules_thick_iter_free(i);
+	optimize_obj2mod();
+
+	/*
+	 * Read linker map.
+	 */
+	read_linker_map();
+}
+#else
+static void read_modules(const char *unused) {}
+#endif /* CONFIG_KALLMODSYMS */
+
 int main(int argc, char **argv)
 {
+	const char *modules_builtin = "modules_thick.builtin";
+
 	if (argc >= 2) {
 		int i;
 		for (i = 1; i < argc; i++) {
-			if(strcmp(argv[i], "--all-symbols") == 0)
+			if (strcmp(argv[i], "--all-symbols") == 0)
 				all_symbols = 1;
 			else if (strcmp(argv[i], "--absolute-percpu") == 0)
 				absolute_percpu = 1;
 			else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
+			else if (strncmp(argv[i], "--builtin=", 10) == 0)
+				modules_builtin = &argv[i][10];
 			else
 				usage();
 		}
@@ -780,6 +1401,7 @@ int main(int argc, char **argv)
 		usage();
 
 	read_map(stdin);
+	read_modules(modules_builtin);
 	shrink_table();
 	if (absolute_percpu)
 		make_percpus_absolute();
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index cf72680cd769..67361b09fcaa 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -725,6 +725,25 @@ static struct conf_printer header_printer_cb =
 	.print_comment = header_print_comment,
 };
 
+/*
+ * Tristate printer
+ *
+ * This printer is used when generating the `include/config/tristate.conf' file.
+ */
+static void
+tristate_print_symbol(FILE *fp, struct symbol *sym, const char *value, void *arg)
+{
+
+       if (sym->type == S_TRISTATE && *value != 'n')
+	       fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name, (char)toupper(*value));
+}
+
+static struct conf_printer tristate_printer_cb =
+{
+       .print_symbol = tristate_print_symbol,
+       .print_comment = kconfig_print_comment,
+};
+
 static void conf_write_symbol(FILE *fp, struct symbol *sym,
 			      struct conf_printer *printer, void *printer_arg)
 {
@@ -1058,7 +1077,7 @@ int conf_write_autoconf(int overwrite)
 	struct symbol *sym;
 	const char *name;
 	const char *autoconf_name = conf_get_autoconfig_name();
-	FILE *out, *out_h;
+	FILE *out, *tristate, *out_h;
 	int i;
 
 	if (!overwrite && is_present(autoconf_name))
@@ -1073,6 +1092,13 @@ int conf_write_autoconf(int overwrite)
 	if (!out)
 		return 1;
 
+	tristate = fopen(".tmpconfig_tristate", "w");
+	if (!tristate) {
+		fclose(out);
+		fclose(tristate);
+		return 1;
+	}
+
 	out_h = fopen(".tmpconfig.h", "w");
 	if (!out_h) {
 		fclose(out);
@@ -1080,6 +1106,7 @@ int conf_write_autoconf(int overwrite)
 	}
 
 	conf_write_heading(out, &kconfig_printer_cb, NULL);
+	conf_write_heading(tristate, &tristate_printer_cb, NULL);
 	conf_write_heading(out_h, &header_printer_cb, NULL);
 
 	for_all_symbols(i, sym) {
@@ -1087,11 +1114,13 @@ int conf_write_autoconf(int overwrite)
 		if (!(sym->flags & SYMBOL_WRITE) || !sym->name)
 			continue;
 
-		/* write symbols to auto.conf and autoconf.h */
+		/* write symbols to auto.conf, tristate and autoconf.h */
 		conf_write_symbol(out, sym, &kconfig_printer_cb, (void *)1);
+		conf_write_symbol(tristate, sym, &tristate_printer_cb, (void *)1);
 		conf_write_symbol(out_h, sym, &header_printer_cb, NULL);
 	}
 	fclose(out);
+	fclose(tristate);
 	fclose(out_h);
 
 	name = getenv("KCONFIG_AUTOHEADER");
@@ -1102,6 +1131,14 @@ int conf_write_autoconf(int overwrite)
 	if (rename(".tmpconfig.h", name))
 		return 1;
 
+	name = getenv("KCONFIG_TRISTATE");
+	if (!name)
+		name = "include/config/tristate.conf";
+	if (make_parent_dir(name))
+		return 1;
+	if (rename(".tmpconfig_tristate", name))
+		return 1;
+	
 	if (make_parent_dir(autoconf_name))
 		return 1;
 	/*
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 0e0f6466b18d..85a2754fdb6a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -178,6 +178,7 @@ vmlinux_link()
 			objects="--whole-archive		\
 				vmlinux.o 			\
 				--no-whole-archive		\
+				-Map=.tmp_vmlinux.map		\
 				${@}"
 		else
 			objects="--whole-archive		\
@@ -186,6 +187,7 @@ vmlinux_link()
 				--start-group			\
 				${KBUILD_VMLINUX_LIBS}		\
 				--end-group			\
+				-Map=.tmp_vmlinux.map		\
 				${@}"
 		fi
 
@@ -201,6 +203,7 @@ vmlinux_link()
 			-Wl,--start-group			\
 			${KBUILD_VMLINUX_LIBS}			\
 			-Wl,--end-group				\
+			-Wl,-Map=.tmp_vmlinux.map		\
 			${@}"
 
 		${CC} ${CFLAGS_vmlinux}				\
@@ -259,6 +262,19 @@ kallsyms()
 {
 	local kallsymopt;
 
+	# read the linker map to identify ranges of addresses:
+	#   - for each *.o file, report address, size, pathname
+	#       - most such lines will have four fields
+	#       - but sometimes there is a line break after the first field
+	#   - start reading at "Linker script and memory map"
+	#   - stop reading at ".brk"
+	${AWK} '
+	    /\.o$/ && start==1 { print $(NF-2), $(NF-1), $NF }
+	    /^Linker script and memory map/ { start = 1 }
+	    /^\.brk/ { exit(0) }
+	' .tmp_vmlinux.map | sort > .tmp_vmlinux.ranges
+
+	# get kallsyms options
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
@@ -272,7 +288,12 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	${NM} -n ${1} | scripts/kallsyms ${kallsymopt} > ${2}
+	# "nm -S" does not print symbol size when size is 0
+	# Therefore use awk to regularize the data:
+	#   - when there are only three fields, add an explicit "0"
+	#   - when there are already four fields, pass through as is
+	${NM} -n -S ${1} | ${AWK} 'NF==3 {print $1, 0, $2, $3}; NF==4' | \
+	    scripts/kallsyms ${kallsymopt} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
diff --git a/scripts/modules_thick.c b/scripts/modules_thick.c
new file mode 100644
index 000000000000..9a15e99c1330
--- /dev/null
+++ b/scripts/modules_thick.c
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "modules_thick.h"
+
+/*
+ * Read a modules_thick.builtin file and translate it into a stream of
+ * name / module-name pairs.
+ */
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file)
+{
+	struct modules_thick_iter *i;
+
+	i = calloc(1, sizeof(struct modules_thick_iter));
+	if (i == NULL)
+		return NULL;
+
+	i->f = fopen(modules_thick_file, "r");
+
+	if (i->f == NULL) {
+		fprintf(stderr, "Cannot open builtin module file %s: %s\n",
+			modules_thick_file, strerror(errno));
+		return NULL;
+	}
+
+	return i;
+}
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name)
+{
+	size_t npaths = 1;
+	char **module_paths;
+	char *last_slash;
+	char *last_dot;
+	char *trailing_linefeed;
+	char *object_name = i->line;
+	char *dash;
+	int composite = 0;
+
+	/*
+	 * Read in all module entries, computing the suffixless, pathless name
+	 * of the module and building the next arrayful of object file names for
+	 * return.
+	 *
+	 * Modules can consist of multiple files: in this case, the portion
+	 * before the colon is the path to the module (as before): the portion
+	 * after the colon is a space-separated list of files that should be
+	 * considered part of this module.  In this case, the portion before the
+	 * name is an "object file" that does not actually exist: it is merged
+	 * into built-in.a without ever being written out.
+	 *
+	 * All module names have - translated to _, to match what is done to the
+	 * names of the same things when built as modules.
+	 */
+
+	/*
+	 * Reinvocation of exhausted iterator. Return NULL, once.
+	 */
+retry:
+	if (getline(&i->line, &i->line_size, i->f) < 0) {
+		if (ferror(i->f)) {
+			fprintf(stderr, "Error reading from modules_thick file:"
+				" %s\n", strerror(errno));
+			exit(1);
+		}
+		rewind(i->f);
+		return NULL;
+	}
+
+	if (i->line[0] == '\0')
+		goto retry;
+
+	/*
+	 * Slice the line in two at the colon, if any.  If there is anything
+	 * past the ': ', this is a composite module.  (We allow for no colon
+	 * for robustness, even though one should always be present.)
+	 */
+	if (strchr(i->line, ':') != NULL) {
+		char *name_start;
+
+		object_name = strchr(i->line, ':');
+		*object_name = '\0';
+		object_name++;
+		name_start = object_name + strspn(object_name, " \n");
+		if (*name_start != '\0') {
+			composite = 1;
+			object_name = name_start;
+		}
+	}
+
+	/*
+	 * Figure out the module name.
+	 */
+	last_slash = strrchr(i->line, '/');
+	last_slash = (!last_slash) ? i->line :
+		last_slash + 1;
+	free(*module_name);
+	*module_name = strdup(last_slash);
+	dash = *module_name;
+
+	while (dash != NULL) {
+		dash = strchr(dash, '-');
+		if (dash != NULL)
+			*dash = '_';
+	}
+
+	last_dot = strrchr(*module_name, '.');
+	if (last_dot != NULL)
+		*last_dot = '\0';
+
+	trailing_linefeed = strchr(object_name, '\n');
+	if (trailing_linefeed != NULL)
+		*trailing_linefeed = '\0';
+
+	/*
+	 * Multifile separator? Object file names explicitly stated:
+	 * slice them up and shuffle them in.
+	 *
+	 * The array size may be an overestimate if any object file
+	 * names start or end with spaces (very unlikely) but cannot be
+	 * an underestimate.  (Check for it anyway.)
+	 */
+	if (composite) {
+		char *one_object;
+
+		for (npaths = 0, one_object = object_name;
+		     one_object != NULL;
+		     npaths++, one_object = strchr(one_object + 1, ' '));
+	}
+
+	module_paths = malloc((npaths + 1) * sizeof(char *));
+	if (!module_paths) {
+		fprintf(stderr, "%s: out of memory on module %s\n", __func__,
+			*module_name);
+		exit(1);
+	}
+
+	if (composite) {
+		char *one_object;
+		size_t i = 0;
+
+		while ((one_object = strsep(&object_name, " ")) != NULL) {
+			if (i >= npaths) {
+				fprintf(stderr, "%s: num_objs overflow on module "
+					"%s: this is a bug.\n", __func__,
+					*module_name);
+				exit(1);
+			}
+
+			module_paths[i++] = one_object;
+		}
+	} else
+		module_paths[0] = i->line;	/* untransformed module name */
+
+	module_paths[npaths] = NULL;
+
+	return module_paths;
+}
+
+/*
+ * Free an iterator. Can be called while iteration is underway, so even
+ * state that is freed at the end of iteration must be freed here too.
+ */
+void
+modules_thick_iter_free(struct modules_thick_iter *i)
+{
+	if (i == NULL)
+		return;
+	fclose(i->f);
+	free(i->line);
+	free(i);
+}
diff --git a/scripts/modules_thick.h b/scripts/modules_thick.h
new file mode 100644
index 000000000000..f5edcaf9550c
--- /dev/null
+++ b/scripts/modules_thick.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MODULES_THICK_H
+#define _LINUX_MODULES_THICK_H
+
+#include <stdio.h>
+#include <stddef.h>
+
+/*
+ * modules_thick.builtin iteration state.
+ */
+struct modules_thick_iter {
+	FILE *f;
+	char *line;
+	size_t line_size;
+};
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file);
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name);
+
+void
+modules_thick_iter_free(struct modules_thick_iter *i);
+
+#endif

base-commit: 231bc539066760aaa44d46818c85b14ca2f56d9f
prerequisite-patch-id: 9127e897a5963bc0a2921151e485e1f870299213
prerequisite-patch-id: 2cc7a98b13bb91d6e2ee36318fa45d4dba5e2ec5
prerequisite-patch-id: 004539d3cc70992506e37571b9ca0bcbf084b000
prerequisite-patch-id: 707a3559cb79bb5c92068ff15ed16c685ff183cc
prerequisite-patch-id: 4d25e4a8d37bc7de517b4e62af96139215bf9bd5
prerequisite-patch-id: 4c08fb77b7163210a0c460c50b5597cb5cc9675d
prerequisite-patch-id: a7e7ae28da8f0f115fb0c5ed39963afc1ef85cbb
prerequisite-patch-id: 049797d97c1d5b5abc534b6869cc1bd7408f3774
prerequisite-patch-id: 6d6a46846a3cc9ed65113791c73e762f144ac938
prerequisite-patch-id: 79e2c3f6cd2be42f6420445a2c7ff4f3d6f24923
prerequisite-patch-id: 1886ff8e7ce9f96d3ff74685723154143a9438ff
prerequisite-patch-id: f0034bc959862f9ca8c71f448c16b8f19f3abb88
prerequisite-patch-id: 6170ba42e9bd800c2196bd82c099a17b5b6ef7cb
prerequisite-patch-id: 98d3737c95b7ebe30f99d8cce0bb43be54a67d77
prerequisite-patch-id: b9b875631dc50cbaa1158dda2d7d1996ebfcea2e
prerequisite-patch-id: 59c9060af2535e33e9a3a68d97a444faafa3afdf
prerequisite-patch-id: d6b21356e663cf0e1a3438bb36d628ac6147dee2
prerequisite-patch-id: 1760308311211674ee1664d1021b3e836cd56428
prerequisite-patch-id: 1f2d76a89dd4ebca5ae75067be4bf9409294e02c
prerequisite-patch-id: fd1dae4678a00da365925ae6e58f4bb39c663f1f
prerequisite-patch-id: 1a0d793b9490b36c7749a17c36d055a043e912a8
prerequisite-patch-id: bf73d8d5762d61abbb39047f5447070a357083ba
prerequisite-patch-id: 514977085da38808f543c662cadbcdfb975057eb
prerequisite-patch-id: 873b7ef1be3a65e99edaa5abc0ac22523631e7f5
prerequisite-patch-id: 8e5072a926190caab89b6751ef4387a0659d767c
prerequisite-patch-id: faefb166cebf0b1992eff78124004a43405417c0
prerequisite-patch-id: 848013f82183ecdb4d2b0fcc5013b97cd4696641
prerequisite-patch-id: 678d1fe9b1825c241e755cfcbe143d9edb557736
prerequisite-patch-id: c14cda3eaeb3db8d6dd33d4ffc0182f749b8f371
prerequisite-patch-id: 7567cca7f30ce8fd56c25689a3ae0207dcf0b531
prerequisite-patch-id: 83fe0cdf4dfa384c188d4a5ee0dd2119a818e378
prerequisite-patch-id: f0ba5006d897fc7a090ed0bbc4e60e2fa1bac277
prerequisite-patch-id: 1f679f13442c1d761a25fbaca5e1bc029ac704d0
prerequisite-patch-id: 60686b01cb9220121bb4c867b21642485b839fe2
prerequisite-patch-id: 0f121fa034a5d6ad3f50a3716fc8c81c5d2b57a1
prerequisite-patch-id: 6942d43bf4ee1357055e17f45e183ae1a38b84fd
prerequisite-patch-id: 0d29b3ef7f3a520e9a43cb572b37a033334ebcee
prerequisite-patch-id: 25fcfd786f8d08005fbe9e52bae6551fc74e2b52
prerequisite-patch-id: c1850c42fc4e4ded287e2c94a5970ed24c2504c0
prerequisite-patch-id: dbcebe6e38f1097ca007e4306f74b9f23e22a445
prerequisite-patch-id: 033686609e2fd5c51b01e599a9eee085178a0b65
prerequisite-patch-id: c52307cd51cf3a3f1aa9382067d40d1c2c192768
prerequisite-patch-id: 4d18ff5728d5e7108b2966065ab801ebcd5f6382
prerequisite-patch-id: d35c6481e59e31e44b61e18a7935e44bb148035b
prerequisite-patch-id: 41ccff9fc4554c78ecfbfedc361c5d3be3e97dad
prerequisite-patch-id: 017dc621d44d98a39de010c3ef08e8b154f6c087
prerequisite-patch-id: 8f456a70929b447759615a62c62065e2efcd0956
prerequisite-patch-id: e6ee373ab6039c2397d25cc7ebf0e9947070312a
prerequisite-patch-id: f0710154655fc34193d441447a47a81f49a93956
prerequisite-patch-id: 6404ba2ff52a566f665c34f7f042253891bedd81
prerequisite-patch-id: bec6dec57d8adb8f2be0b10f1e3dcac75986e7bd
prerequisite-patch-id: dd026aebde0ccaaa168e7ca4ac0ecc9ec91a2e8d
prerequisite-patch-id: 80a7cff2d41d295b347e132feaaa73692062fde0
prerequisite-patch-id: 408376f10c5845a0989fd5d4234bc5dd3c0bd1e2
prerequisite-patch-id: 01cc6d31855b313ec1f57939fcf3f24e783d556a
prerequisite-patch-id: 44706728969ea4fd9d8ff9377bf3a5eba0cf5419
prerequisite-patch-id: 31b417dd4357d2b3f617e65b2cfc11f699647c56
prerequisite-patch-id: 906d945b27892ef6c91b209d836e4b0cb8c36a04
prerequisite-patch-id: d1451b2a7f31a8a75f8940a6073d3014732c8f33
prerequisite-patch-id: 1ede614ac74ed3840e1bf0d8c6fb5386ca9b6469
prerequisite-patch-id: 2ab30284684ca983d21d9173c813385f7077ce0f
prerequisite-patch-id: b27508c8aa59a46b7f382f1f8a64b7188ed65bbb
prerequisite-patch-id: 70c1050d6a6f971be8cdb5943d04f86fc19c24d0
prerequisite-patch-id: d8a1a87dce088ec3aab68ab3e37fb353a324f2e6
prerequisite-patch-id: fcd342c11b11f1573f4cb686f8aea6954d1827e2
prerequisite-patch-id: 9784729809eb614d2b7f3aaf9ec1c0f82bcab095
prerequisite-patch-id: 3907fabc47b5e5cd26336291631184114846c2e8
prerequisite-patch-id: b41432c6d9fb844eece807b557117c42e31e75da
prerequisite-patch-id: e4376a278b796b9e1065096b1ff627302d3d8480
prerequisite-patch-id: 911983a317d83caaf2f765ee02f90d63bb385e2a
prerequisite-patch-id: 5fb6e5fd667d14f9fe40a960971c59ff29905df0
prerequisite-patch-id: c4ef8538f7a4c70067299b59e55e7ce52ecd2690
prerequisite-patch-id: f685b1fb73d9f56fe78359701087e4c1d8dfab73
prerequisite-patch-id: 6492ef0f7949f63c8bce01747fbaa6f46dd8819b
prerequisite-patch-id: 29d8d8175472e30dace4cad1cde6f5ee8f347659
prerequisite-patch-id: 1fe1805b4b4c76b798c553ab603652fdac8d03a4
prerequisite-patch-id: f9576901adf2c31eb40d818d8f051556860f872f
prerequisite-patch-id: 48df21b17e4a18e9397dbfb7324a91d7c81ce72f
prerequisite-patch-id: 9cbab79bca18798815f6221187dbb1b75ed5d3f8
prerequisite-patch-id: 44452299b6d1107308d046c1ed3101a8f66bb14a
prerequisite-patch-id: 56921914219e7540cfd21ca05d2680dfe65d2453
prerequisite-patch-id: 30b78f65d5d1736f75ce6ee4dd588686ca6df15d
prerequisite-patch-id: be7042e9f3a3287641c18de610700e8adc0b9e70
prerequisite-patch-id: e35f21bd9e416f9ff1ccaa66f56c6054d9f4406e
prerequisite-patch-id: 496b827db9bba2b76eb0497f045b0195e35fff8c
prerequisite-patch-id: 86647654fd1fb481150c25c257fe68f57060356c
prerequisite-patch-id: b23e16747495f84ee757fd433b6713f8ac14ca8c
prerequisite-patch-id: 8de4d31d3a449718ce8fd0e21e687de778b9ae80
prerequisite-patch-id: 712820600d95ec11c8bf0c449964b9fd10d7ac2a
prerequisite-patch-id: 3160f0331fa65e8308334a890c6a7031001ef49d
prerequisite-patch-id: f7839a5eb16d9962164ecbe9e8dce161cfa0bee6
prerequisite-patch-id: 2a2ef72ad6f09e52ba074554054371638b5cee0a
prerequisite-patch-id: 122f8c09ed320dc9e139a9167e868c30902dbeda
prerequisite-patch-id: 074a3d1e4ef6abcb2a66b086606ae0ba4331ec45
prerequisite-patch-id: bfb17657faa43678c17a589f15d1f074aa1895dc
prerequisite-patch-id: 4452f3841ba05f70110e9cc0bbde9c04a16e977b
prerequisite-patch-id: 760fd40d844fd71503762f92434ce391abdd4dd1
prerequisite-patch-id: 89f239afa547cf20f8ef1bb431f2cecd7cd9758b
prerequisite-patch-id: 522a09701815474d91bf2de95aee0c0065fdd144
prerequisite-patch-id: 3666348735f7bf357d2d85314c6d42f718d3bce9
prerequisite-patch-id: 8429ff7169e94240a98fc1ba2b54ce51ea8d80ae
prerequisite-patch-id: f31c1dc3d9a8e73822be7e9e05b40dcd64c9fa48
prerequisite-patch-id: 71863d005b16918583e31fff543734fe138a0795
prerequisite-patch-id: 5180f04e08e8f8b7f11eec8d4523f1e7c286fe44
prerequisite-patch-id: 5a02dd1d6f7cdf73744278e74661a4815aabd5a2
prerequisite-patch-id: 8a6f09e6c4b03af765254cc84cf38a5c359e188c
prerequisite-patch-id: 1d2d14ab02a1b1a006e0576989f52999e3c85343
prerequisite-patch-id: 5283493b2d2bc1128de99fe22b9641df12f62572
prerequisite-patch-id: 361dcaf8542104a2f903a0abd6bc441c9becd015
prerequisite-patch-id: 06fd7546175d66e385e8614e1f580affed3798ef
prerequisite-patch-id: 695b192ab7b5382c2fa58d27b8b6ae58b7cd5be3
prerequisite-patch-id: f70367917d07c30b80f8ca6ecc2926aea429b9ce
prerequisite-patch-id: aadf5bb56acbce3ce774ac965b5946ec2f518e19
prerequisite-patch-id: 643380efcbcee1f503a63bc476f23f60855f92cb
prerequisite-patch-id: 319c5cb6f8494d0530b3d849c80311e60e7192a8
prerequisite-patch-id: 783ca154cb603c5b5229dc1aaf63b2462a9e554e
prerequisite-patch-id: ef96a2cfceccac29a2ec74aef57d6a854d64cd8a
prerequisite-patch-id: 18a631d17d0ecef46d1bec142a70ef540ea0aa5b
prerequisite-patch-id: 2aaf3bd6f87027431bbb9c890b2a5f2ee337284b
prerequisite-patch-id: 1553743fb5079e6d3b355ccb7214a8dc07643152
prerequisite-patch-id: 2f8afe043dcfb17e00a104011af4ae088f4b31d5
prerequisite-patch-id: 7b1ad63bf16fb6972cca8d58303674569d89dd88
prerequisite-patch-id: 8e936201b4296d22a9d432d1125c39631b5ae516
prerequisite-patch-id: 6d60a5e37782d74fa563c3d88821db838707778e
prerequisite-patch-id: 6052c703ab56e50cda85385379034ccd7e0856e5
prerequisite-patch-id: 8e0f99ea0f7a4148570e09fe790ebe78adf928fc
prerequisite-patch-id: 4e1a171898875fa30cf0d2510e14506e9c400ee1
prerequisite-patch-id: 2f520ce3c98a5aecd13506bd8e19a866c0bf32b9
prerequisite-patch-id: 87855e5cf4f66df72f7a2e95cbed741162d28dbb
prerequisite-patch-id: 4cc0dab0554744511ebd9c13acb6ba3237703a3b
prerequisite-patch-id: 2c2f5d24cb9b69344ef34ea5679dbcad4aca844e
prerequisite-patch-id: 3b7e0ea565813330eb37d390483e2639de9e6496
prerequisite-patch-id: 025efe5255cf2d93ca9c74c481cdeee4dde49755
prerequisite-patch-id: e9ce64c6341b566d91487341991532f372bc74c2
prerequisite-patch-id: 4aa3f32237bcb9fa7a1b0927a105842919c99efb
prerequisite-patch-id: 77e30fe711e85416482280bd5ab3e15e59f7511c
prerequisite-patch-id: 00d64f59a667229c4b88f3e17c9468c7fa0b684c
prerequisite-patch-id: 62b60e05fb32a51ac3dd7101bd30a97f79b5766b
prerequisite-patch-id: 5c2ad978c8cc12fbe977433771e885a61b3377f9
prerequisite-patch-id: 7f3b77edfee4b6cb7518a19eb228a9c0ecfbc48c
prerequisite-patch-id: cb1925db8880e52cb1518781f1bbdcd601db65f0
prerequisite-patch-id: 8b861cbb95885fe3c4792ce3440729d60ada4b02
prerequisite-patch-id: 92a17b907a04cd4f97ccf74b8ba7a7f5b2deb0bd
prerequisite-patch-id: 932fccb3c448dff11208cd2cf064e98e29a2c1b8
prerequisite-patch-id: 92ccd68be485d74ff16a6d89ea52a43f276f8bf5
prerequisite-patch-id: 28ef276e35e04ff5714322097f7327013ed71b0e
prerequisite-patch-id: 985d0927fcb1a647d62124bb6975bee0ab239957
prerequisite-patch-id: 5f319f755a058541e8ad0ef34858b570d7bc62ee
prerequisite-patch-id: 58071f1c1806cefea80c47be71a8d7c4a10a3678
prerequisite-patch-id: cef310bdc32a0aacea2630b88130be08563eed76
prerequisite-patch-id: a00971ce9f20af8eee6616746104a6b5a19b5cb5
prerequisite-patch-id: 69eaf873ed7ae4bf3391195184d13d6cb313bfaa
prerequisite-patch-id: ab12e3ebf59d57d73eaed8d87cbb00812e1d4599
prerequisite-patch-id: 47330714a0619d5f07466d3000f8109251ac1988
prerequisite-patch-id: 3a048b00c4e4f1d7654695ea5cd672f902815ad0
prerequisite-patch-id: aa09535c0629565ce76a96f64d6fd878d40c6d9e
prerequisite-patch-id: 673d129bbf3e77f530507c5eb0f0f210ce51924f
prerequisite-patch-id: 0592e6f7535274f6db1bdf3e7f2e638a710dabad
prerequisite-patch-id: 0a885bd5a9bac7f061dff920f02cbecf2bd25983
prerequisite-patch-id: 0e38b3b18ab0eab625ba87423ee972e5573861ca
prerequisite-patch-id: e45e57d89152b11b306d629b1bb1a609f4919335
prerequisite-patch-id: d7e2ff5463c78de81393f97eca2b8baf37515920
prerequisite-patch-id: 1c2f55c8eca56607460e9d6964cccf922a03acbe
prerequisite-patch-id: f72c7968b71c74cd9d3f5ff17fe75eb35f042e45
prerequisite-patch-id: 48115c5dcbace81c22f0afbd8c5bc3be2eaa5fe7
prerequisite-patch-id: fe7dfd2047d7453104b5f9c615a91845ba1993e1
prerequisite-patch-id: c9a5a498ac7dcf758ba29138036e9f3b0bdc4e8e
prerequisite-patch-id: a8d0ecee726bfd4e5fb6c42bd5ffd9faf4a17fd2
prerequisite-patch-id: 0e560053855a1ec42f64b7741700ac7f54aff6a0
prerequisite-patch-id: 2c0d2b971e601299486a046106510423cf5d1c75
prerequisite-patch-id: fa22bc70c1169b3a7b985777a5afacf50b399766
prerequisite-patch-id: 1921cb0e10d0ea7de2064d9fbcdcc1d3e9708d1d
prerequisite-patch-id: 32bbfcef74beaeed043f2c312368652892f59788
prerequisite-patch-id: 9a31894f33e671da79c1fa618c116c79616a0c9e
prerequisite-patch-id: 2a56f3224d56c19ebbd203dfc09f4a4d4e6dbdbd
prerequisite-patch-id: 12c63416c83d1b875b797effa67dc3aff853d014
prerequisite-patch-id: 4386d0cf0a3f57ae09290bb6405ddad9dddf2d41
prerequisite-patch-id: 331460ae313b9febbd990a77411fc76d2f066edd
prerequisite-patch-id: ce28ca6a4d9c886eedcb9b5ac655cc2468b6f60b
prerequisite-patch-id: 01ddfd3ba933c8ade643c27ed9764fa0549e6979
prerequisite-patch-id: f73e9dce4be97dd8365d4741ac24fdc0cca891e5
prerequisite-patch-id: a3eea31fba472df2118a52b0d6b92563d6b1e1d6
prerequisite-patch-id: c95cf9fda0281a752f9a05b87932f1c084e1fc43
prerequisite-patch-id: dcee802e8fe9e170f1112434c543290bb61ade0b
prerequisite-patch-id: 18a050928709352c8454e6102bcc141080bea680
prerequisite-patch-id: 1019292df608ba589a7f80eb04ff292e4761b8ae
prerequisite-patch-id: 7b1a663d8994c8ec0dc61c1871dbf4de604484ee
prerequisite-patch-id: ff235f5b1d0e7c3f215f69429468b9ebe679f95f
prerequisite-patch-id: 0416f3d4285817d91e63e3d0b7a93e9d10837e82
prerequisite-patch-id: f9a829a158369c69e46345014d887dd6c10e67f4
prerequisite-patch-id: b1031cb0a899c3b294286fa8b8cdd5c23d7bb9b6
prerequisite-patch-id: cb121af2af65d9d9f44cc2bb72108bdce4c53809
prerequisite-patch-id: 93da51abbe7b5be3017e7360703eb1cd8ec2b3cc
prerequisite-patch-id: 5ede7ffeb003d89647eb031c1e9ad7940f4455d6
prerequisite-patch-id: 18f494c25f6c9e9b146d2db30240e16d2f966a05
prerequisite-patch-id: ca6a0e8eeb220f3b02572309363ade2dba4ff430
prerequisite-patch-id: 3b81ecc5e0bee16aa3079d2277958f6392c10fd7
prerequisite-patch-id: 0d7d4d6612db6173008a6b044d73859de8c4dfac
prerequisite-patch-id: 301ca83ea776c96b07da1ecaae9450dcbf354f14
prerequisite-patch-id: 8547cf05a3d489b9f45a472ab7407033ba0ad741
prerequisite-patch-id: 05a1476332a0cf6fce9b7c8debb1b315367f8c95
prerequisite-patch-id: c4512adaadc8113acdb6ba8dca050417ff88af6a
prerequisite-patch-id: 4a66b9bcb3f8099cff6ecfba5d7664f5fd105550
prerequisite-patch-id: d22f095ad8161b2ce1d24fdce373b290a2ef642d
prerequisite-patch-id: f3d51d1a90e1c47781318692af44378a0c080887
prerequisite-patch-id: 554437d0adcf074668b2effa493c9ebc893dbdf9
prerequisite-patch-id: 878ac1ba1565b41caac8a2b957e4da4f484ac967
prerequisite-patch-id: 2bb3f26b8938db8694488b7c464f13df3118cf09
prerequisite-patch-id: 7e4b83381bfc354102b47b454b3686b4bda5be8e
prerequisite-patch-id: c3a099b6f8539398d72943a9c32df7bb33ee2f29
prerequisite-patch-id: 23fd979bb72e65d1d73ad0549637a15fa4822c06
prerequisite-patch-id: a72edf7f45ec5f4e13c326a848276cc6ae250d86
prerequisite-patch-id: 588d1e07ad405a40fcfe0563f9950ddecf89a3d0
prerequisite-patch-id: 4365b29ddc1bfff5db4ccd4bb9b1e9557300943a
prerequisite-patch-id: 8f6978fcaae48986ebe318bee08b0f06a587829d
prerequisite-patch-id: c6e23db96586653b5a4fc8496e0c0cd98757de14
prerequisite-patch-id: 58d9d3dfd766616c80238b71b394163247a9f09c
prerequisite-patch-id: b40ead8ce6492a4bcd933f3804a69052f55286ff
prerequisite-patch-id: ea0e368fc9799bb450776e10883addf68279e352
prerequisite-patch-id: 20471db7eb2b481fbebbb032fc0d1c03006bfab6
prerequisite-patch-id: a0eb07011280728ae271ce47d502e9f7840b4c8a
prerequisite-patch-id: 332e62f6010d0ef744d68113052bd8e66365a0f9
prerequisite-patch-id: c10c57e3fb14006891004ea87dd9e5ed99af9e3a
prerequisite-patch-id: 57b9410a2d879cea2314282524197f7aed856bc2
prerequisite-patch-id: 8a43c857ab44e7194d6bc60efc8557b6844c4a55
prerequisite-patch-id: 703837d3f4e620072790fce78c762eb02a923f08
prerequisite-patch-id: 39b16c0a931ee2115d04a12440946af715c19cc5
prerequisite-patch-id: a081be916d3d47fa731d53b8c34386fb397015e8
prerequisite-patch-id: 46070ad6bb4c4b51ed1b0a12c05b8234a90ccb8d
prerequisite-patch-id: c466730ddf322ca44b1876fe5ca8bb6af1fa2503
prerequisite-patch-id: 5bcce7e286cc0a6e3772e08643ac98a85145d09b
prerequisite-patch-id: 444881acfffdd44ed366a85e59584c8746ffde9f
prerequisite-patch-id: 833ef2aa697eb5816c850cc08afaffe4ea8d1f52
prerequisite-patch-id: 4a442df68eba40c0e5bb3a488c9299a8752f6560
prerequisite-patch-id: a427d32215f366e5c0eed16bbdb3666601f85042
prerequisite-patch-id: c4d61ca457bf53a5137eac191f4b34790114bb61
prerequisite-patch-id: 0d08a79eff184160d5d2ef76660cabde2f143300
prerequisite-patch-id: 0ee9a0a23e38b9831f176a8fc9312d3f49f240e3
prerequisite-patch-id: f5679cfcaa39ed6f228c8a9d9890a24655032613
prerequisite-patch-id: 5951646f3eddad09e82ad2ee0e1fc3df9580c6f8
prerequisite-patch-id: 7e9f74e87d7b95bb2b102da1e8fe202c514603a1
prerequisite-patch-id: 2a0ca99412dd868f6dddba2527d887180d68b0ad
prerequisite-patch-id: 7d4f3f08af2cd01169712efa67c083623b693e54
prerequisite-patch-id: 65e1b43184b733d25a609492c2e2490541743e76
prerequisite-patch-id: 24620e5250bfa4125048cd5807327fb333c5b6e2
prerequisite-patch-id: 3e4b558800f3656fb812549a147cf47e536e07f0
prerequisite-patch-id: 391c0243fecf23506c6dfc653d801ad6c9bd2f7b
prerequisite-patch-id: 12c7d7d9d0e363a6e92a77e67b0936ec44800e07
prerequisite-patch-id: 82a31b00e1309fd1a4a6c75d6682f5fc7fa2b76b
prerequisite-patch-id: 4e583fa6cd8c6894cf9b2b69dad83026f4bb18f9
prerequisite-patch-id: b23f10b0292b13365d3fd9beca44bc7ad7de6f29
prerequisite-patch-id: aa14483d8f5a52fa4ccdee69d46ab403cad966b3
prerequisite-patch-id: 12cd3b542a7b53d275c1795784d1155671b442e5
prerequisite-patch-id: 7fa2b3bfa41355b06ed6f6505fe0e31d9d11b6f0
prerequisite-patch-id: 53e260943ae9ff388ff1c6e9e2ed4b74f29515aa
prerequisite-patch-id: ab8905f6dfb4e046ca9d72cd299a9005da209ceb
prerequisite-patch-id: f4dff7a31dcbb3493d7dfb6785610684ac04f8d8
prerequisite-patch-id: b40c523274cc6f552db65887f61dccc2831e0e90
prerequisite-patch-id: 30b28b9ee891c8a90a1e3b581a1633cf8b2b7942
prerequisite-patch-id: 324cb9c3b02d8b36cff729526a0176284324d476
prerequisite-patch-id: 4ac13810061b7f08c0ec1f792fa60340d83aec0d
prerequisite-patch-id: cab007d90ab2594b4813f56a3d3ec12879c5f4be
prerequisite-patch-id: d64364aaaa858cc974071aae88213df8205f1e73
prerequisite-patch-id: 2435768bb436fff826bdd55f7b014c6e005ee0fc
prerequisite-patch-id: 4e1ca42c7d6eb795f7e521282b1b0305ce4a98b2
prerequisite-patch-id: ce4e6972153a4929cedccf2b2d57fcd45262c7f7
prerequisite-patch-id: dfa068999e42ae686a9dec71d55bd26fcf03a29d
prerequisite-patch-id: a8aab8566602b6b023a69762620acb40e5c3758e
prerequisite-patch-id: 2161411d18f8fdf7632ed534cff33be78fdf185c
prerequisite-patch-id: 2b4a878e86c76d40362a60917f0dc0e2a1466ab9
prerequisite-patch-id: b5773950a4f703a4738bd77c04b9bfe5e4c8cb51
prerequisite-patch-id: 2e382be86c27a8e1669ff27cedc3d181635c3702
prerequisite-patch-id: 5b20ac63bb451c256d92ed12e8028763abb4c97e
prerequisite-patch-id: 970d3325d737ed80b26780f49269a2a2590f134c
prerequisite-patch-id: 29eddd5eb2324f963753403a47864180e3d49ae0
prerequisite-patch-id: 3d1f074b403ac062989d74f35360fd20b7b2183e
prerequisite-patch-id: e01eb7a3c811e0c19835b5a29e7a1a402096147f
prerequisite-patch-id: 9d0868ba8abacfc9fbb2649189294beff91ccfbb
prerequisite-patch-id: c6750ae39a9268ee6cde5e0ddf1a4590198d9f0e
prerequisite-patch-id: 4a5aa4fab79607ea064608ad6397aa41f6126e1a
prerequisite-patch-id: 4a7710c9089bbaee291bd6ed77f4c7ee15941b70
prerequisite-patch-id: efde59bc5d5d474e9652f01854f62c0094330537
prerequisite-patch-id: 5fbb613b831b65eb211252301a458cac6545be86
prerequisite-patch-id: 03d575f9c79ebcdcb3885d067deb62c746412a4d
prerequisite-patch-id: 4410c9c4bdcd8f7e3d0604654463140dd9a0be60
prerequisite-patch-id: 5c148d9d5df46bf095ecbc147f7ecd07dc9ac9f4
prerequisite-patch-id: 2f113d4bcc1b8e138e9fbef6f520459c714801a1
prerequisite-patch-id: f6bdfd5cb7f31ecc5565562ee73c7f3bec3983b5
prerequisite-patch-id: ee2e8cff814e12ed6498280f0ac7d8f47cc7455e
prerequisite-patch-id: a8cfc4401ad35fd5c055727a012cd0bee8f7e0a9
prerequisite-patch-id: c4c4fda27e1aef5ea98b6a6d4020fb94a9fcefe3
prerequisite-patch-id: 46fe18140e612329ad4333a67dbdecc479ced26e
prerequisite-patch-id: a338e9f19598bd4b3f863d222fa9b7d7e27af91c
prerequisite-patch-id: f2749c877886935382f32d7447de99e0125f511a
prerequisite-patch-id: bb3a42a2fec4b68a6c1424d7a23ed0d3b074ad28
prerequisite-patch-id: 26321c240edfe7bef5c2f3403847801d4e8bd145
prerequisite-patch-id: f0d487425e022fd41fb6d93a05597620c27bdf34
prerequisite-patch-id: a0d54a49c431889eb849c5ab2352796a058942b0
prerequisite-patch-id: 2d9163121ab473b02dc9878c0ff7cff3cc191a9c
prerequisite-patch-id: 7a3db65a4e8aa04a04bce5ef74e8deac494cf969
prerequisite-patch-id: eb428bacbeb85de6c2f0d68486eda5ad7dd82583
prerequisite-patch-id: a835aab1b01d012bd35756ab966941238523745b
prerequisite-patch-id: 00d092dd8e5276b18c58dd08db9eecbaaab24cd1
prerequisite-patch-id: 7ee4a80143d4da3747efd27e3b705e4f151051d7
prerequisite-patch-id: 1c684fc0cdb82d9dde41db48560ffe6ccb7f0427
prerequisite-patch-id: c9afb0edca29798f844a7b5a64eb398a4a877f69
prerequisite-patch-id: 6011099c53a1f4911ed89970277a14b5b93405d4
prerequisite-patch-id: 4fbc0e38d2764e0f1fd6f1a7b0aca71316782840
prerequisite-patch-id: e7ce6d44196b952057edde003b12d9f2f0b1eaf0
prerequisite-patch-id: 4a1a1a95bf95b498fcbea9c65b9219ebaaf186af
prerequisite-patch-id: 2f36aed9638daf4417f7253c17d1256c8b421690
prerequisite-patch-id: 2eb6ab00986ae894762a8cab7ac5f93fccc11ee2
prerequisite-patch-id: 94950d06ef9d4045a553fbaf9d825928fe980a54
prerequisite-patch-id: 86b7c7e6347d8f2f464724c3f1fb94aba7ff113d
prerequisite-patch-id: cc5b53c993f7667635edca920eba8845afeeb24d
prerequisite-patch-id: 3eacf114b9674dac6bad8da8c8231c91535c31da
prerequisite-patch-id: 5ee06283edbe65821db641fe91a429016ade7ebd
prerequisite-patch-id: 9c9907b04c36c879956a24b3c8a3dbb8917f4b2f
prerequisite-patch-id: 270906bfc441ac84deb95df7f6883cfb28287f1b
prerequisite-patch-id: 31715532bd363687ffa3e89eebd422c2aea3b584
prerequisite-patch-id: 35a074878a05625c5a94a5e90f3a9c0559d9edc0
prerequisite-patch-id: 7e62b5b7241a1d458e2411d5357a9bcb530a1554
prerequisite-patch-id: cc4c5a106045c2f96347721e2399abdb46498e1e
prerequisite-patch-id: feca07a842af160f76abd352e69ff26d600f64da
prerequisite-patch-id: 544824b75ff6e1412917d40a80b02617e8229cf1
prerequisite-patch-id: 9d0f7688548bf7ad80ca03ed5ae3d0ec2c0b86f9
prerequisite-patch-id: c1398a2f59683ef9d459c1a802fc055baf16d265
prerequisite-patch-id: a30df8c13feb18190deb271c7a334ada3e022a23
prerequisite-patch-id: 8b2a520b8ef78aa73ceeb3df17fcf2ae604fbddd
prerequisite-patch-id: 9ad16cee85d1c7980dba037084d50487b99a9c5e
prerequisite-patch-id: d6b0b5b7ddb7b839a9cab9ca5ff430a0c50418d6
prerequisite-patch-id: 08cb81b0fd1bb88f6c3e5f49b4ec06ea8ebe9698
prerequisite-patch-id: dfd7afc312fe6c0728988aa6276bdd1c758d0ded
prerequisite-patch-id: 194f933466219e470965184c0dd6972f53d4d996
prerequisite-patch-id: 2e97811d63e62b46ef93b70c6e95484ea1cc2498
prerequisite-patch-id: 964733c4ed71421fbaa4b6dba8f88d0577aeb318
prerequisite-patch-id: 0c6c5a7320ab1135c1bd98a71780e3735e425df0
prerequisite-patch-id: f93467b9ed1ed9f479c93e7cb0c3913bba474498
prerequisite-patch-id: d5db247fda04fa9b099794bed7638c36bf8fb6d8
prerequisite-patch-id: b6eb894ba5f1039211abcc1a93a53f06d1f09700
prerequisite-patch-id: 4a3951c7bc2773857f5f02225fb3ca083faf277c
prerequisite-patch-id: 01a2f523595d84d7a6615fdbbe6bb590a2be6fc0
prerequisite-patch-id: da5ef013f03ceac6997a52086b43669dcdd8c1ee
prerequisite-patch-id: 9d07e05744d26f036b0b1f147cdd6ed288193fee
prerequisite-patch-id: 3ac77b8c9aeb5651c9396eb62ecb9c18650c2f8f
prerequisite-patch-id: dbe8b0538c6e4bf03525428c8a3613785087b37d
prerequisite-patch-id: bfa5cf113cd04f6bcab550d7d9b3ed287c77ae7d
prerequisite-patch-id: 0d3f570fda21d9c49257dbba5c3b505880a5537a
prerequisite-patch-id: f388e97b2e8840ef016f8574446f996a0a2a4a99
prerequisite-patch-id: 7cb51416e877dd8c9ab123853e96fd25ba9783f5
prerequisite-patch-id: 21b61387b25149dd4de1fba54c0ee225ce4b0b9e
prerequisite-patch-id: d5fcdbe6e64607efae4f2a51babe4df5fbf3007f
prerequisite-patch-id: d7031a183dd53524edeb575d1b361c998b96bff2
prerequisite-patch-id: 4e93c6866aa6c0b0cb837ded6fe061eacbea27df
prerequisite-patch-id: 4aa68911e0d48a5281f190dbaf10274bec40e54f
prerequisite-patch-id: 1dd901c7bf46e50c97992207c9a5b5b2412cca08
prerequisite-patch-id: bfc42e757f1b5bb3d0f89f8158257c231205ee2f
prerequisite-patch-id: 1604bdced87fbc7e2098832cc37bfe5985b2c9f9
prerequisite-patch-id: d9bc6526bb88217a1e783169a327d744a35ed854
prerequisite-patch-id: f4c0825d5f3bb29ac65332c388f8c011da4fde31
prerequisite-patch-id: a25b391c75f3aa7234b0561f18b0f754689b7445
prerequisite-patch-id: e62662c9b9cffadbe18ab84318601e3cc2c7b12f
prerequisite-patch-id: db07afce46280ab58d4266be41c8e040b81641cb
prerequisite-patch-id: bb198f620ba5be03ba8f71af31888cd8091fbb74
prerequisite-patch-id: dfc770109d72df4ac566c5ba6ed09d5acd459995
prerequisite-patch-id: 4a12305627afba4775c701f3aa6c8bc59ddb63ba
prerequisite-patch-id: f89a8d1d27bfe0cab56e65140dfcc2d3ff1b7509
prerequisite-patch-id: 9424c566d834ae36474f92f0618f8eadac61d411
prerequisite-patch-id: ecb646f6a9b98cbca91e65a0156257c2d2d3d5f4
prerequisite-patch-id: 6b7e12e3c2abf2e77b6dd7b26bfb103a6dae76f6
prerequisite-patch-id: 2ce680c069c0a2d446e4a0da0decdc6d74916029
prerequisite-patch-id: 8d26e9a08b9c32f50e9e9642a8697d9dc1522390
prerequisite-patch-id: cb722bbbf99e1d0d39763db83cf3693c21130226
prerequisite-patch-id: 96cdd4c96bb8d985c4a5568a11c3d14b4ae50e6c
prerequisite-patch-id: 9b78084337ea76485aceea6db6f2f5c74136c4e8
prerequisite-patch-id: 9e8a1e2b9f57864d028c6c15be7c7d57a71b99ed
prerequisite-patch-id: 28efaaaf49e1b992de5e2d9c307eb548ad5fb323
prerequisite-patch-id: 94abd1a93b01ca8c6d9c45264a259a87760ad0e1
prerequisite-patch-id: 9e1a0fb3a2b40dc573aecfa53fadf7d44edd8ed9
prerequisite-patch-id: 7f14d8e05673cdbc71f3c1e394a88400439bb134
prerequisite-patch-id: 1ee92abf5808f93b36be9c4c7d12c63961f4ad5a
prerequisite-patch-id: 335e843a91db930c82e73b032d9c30551784b89d
prerequisite-patch-id: c65d9889bdf71487a5a51f43693147b5aa346510
prerequisite-patch-id: c54a1b76c30281b6a2210e40138d376b52df8d0e
prerequisite-patch-id: 6fe37633b1bf334091ec83f2ae18e4beb53ac1f3
prerequisite-patch-id: d0a7c36e55fa27e2336e180642c7982a6d8e2cf0
prerequisite-patch-id: 98ae546d4e2a5d8f9f17a0e7081c4cd6bb6ae118
prerequisite-patch-id: 4aa060262e3ef8bf989a03a4078e1d30cef673e1
prerequisite-patch-id: 9a4f9671e15101f962e0626137465bfbdbc0b231
prerequisite-patch-id: ea0325a8f6d1594bee3eabb3b4962243fef8a851
prerequisite-patch-id: 0e0b4b054324f0d5e6a4066ac95b3b791ba779dc
prerequisite-patch-id: c14e000e3237417c413486c41eabea5254a820e1
prerequisite-patch-id: 33bd5ee198359309927995bc8012669336a3b827
prerequisite-patch-id: 4eeef74cb768514304c8c4fe82327f442b39ee13
prerequisite-patch-id: 1251217832857c842fa3ea92bc98c1a6631c8111
prerequisite-patch-id: 3eced90623fddb33afa64af2f7cb5b34016f5282
prerequisite-patch-id: 47946a306dc401d2b29eb780f33da8c2d477d9a2
prerequisite-patch-id: 286fd09ab989cd9ce67e9f17a7469b8e60045db3
prerequisite-patch-id: 42878330f024392282a512774a81dc3561e9394e
prerequisite-patch-id: 50592747c9bc31de1c796c541eaa137314a0db32
prerequisite-patch-id: ed6d203fa31a4b2d948ef3e7b5b72f1f0cc24c78
prerequisite-patch-id: 6bacb155bd57b3b2a6cd709524c09d3b92108593
prerequisite-patch-id: 96825935dc7d38538c6eec66b164761bc671f233
prerequisite-patch-id: 4d020b795b371de5e360fbc5e6aa6a604f4cc3fc
prerequisite-patch-id: 1c9fd0698646d9b6c8ca813f779eec99e3ba9f1b
prerequisite-patch-id: 8c78d3d923d56f5364bd68594776b2880a2f9669
prerequisite-patch-id: 0466ad8b46ed734cdf0a643e2aa2d45d80ce473b
prerequisite-patch-id: bfe73daf2209c0285b021a562e8f771c5ef3814a
prerequisite-patch-id: 2a7db91142ec7ec3709736e5f93ad492e205b70a
prerequisite-patch-id: 59885b38d3d393791380ed3eff811089c1f606e7
prerequisite-patch-id: 778fb694b10ae971866c369c6cbe927fad94924e
prerequisite-patch-id: e58972188a15a5749a25abb28c457a4b39bd23ce
prerequisite-patch-id: 1d75f610997fb6829694d2ff15ba7bf361f6851f
prerequisite-patch-id: b2320c35159749cacf115595ff0ee8eaa98c402e
prerequisite-patch-id: 1e9f331c187a06e4c181ad90106231e23e52e6fc
prerequisite-patch-id: d2ce54cb95006ba295c8794e0c0ff182c4bb163a
prerequisite-patch-id: 26c5eaf501200bf8bff8413a6e08925ac630b84c
prerequisite-patch-id: 0471e88f6eb1ede0325bb363f625bfa996d7e3dc
prerequisite-patch-id: 59f5b712fce05e88ae01ebaa96a7cab19a980a2d
prerequisite-patch-id: 86d97df5eb4bf61417ff114772b9f3edac9f7ec9
prerequisite-patch-id: ebfe2a6f82a07e075beaa42d23c6c849373ce14e
prerequisite-patch-id: a408f74dcd9bd8eb8ff92ecf408ca3d1517fbd96
prerequisite-patch-id: f4b7c5a43ba45e109201365722502f318fefe5e7
prerequisite-patch-id: adbd844cbd26f734b4761ea6c1fcedf78e4cb5d5
prerequisite-patch-id: 1e1ec3ddef9cf70c46b25082b80e35863e8e9679
prerequisite-patch-id: 3536d23bbbf54032734c3c391be0427c8f769075
prerequisite-patch-id: 752ba1bb3ec330ef4b027a47bb40d2702eded447
prerequisite-patch-id: 883f11b3e875b6f4adaaf300789d75b7d10f5e79
prerequisite-patch-id: a48a5cde1216b5f41ce7e7181cb0739956d95930
prerequisite-patch-id: 02400319060c717bba27419be0d9b87175311bb7
prerequisite-patch-id: 1265b896e58c535e66fa26425a4f3ab319e76e56
prerequisite-patch-id: 5cde92e142327ba74cc4c9f0fbe7ce758f804fcb
prerequisite-patch-id: 52431fe7080cfb594f86c0b576a4e5fa55ebcc5f
prerequisite-patch-id: fed3256cb3466f2c3f46a7b5896928baf8ea00ab
prerequisite-patch-id: 7a4dc3c155337da6efe6b02d12c8a651f49abb61
prerequisite-patch-id: 0b2109583f5fd0b0e5491fb065ace4c634f0268d
prerequisite-patch-id: 601e69d8f05f583efd69ad62d489dd91e9497ef6
prerequisite-patch-id: 1bb18dff383aec9e5b3e8f98ec69b432db80f1df
prerequisite-patch-id: bcb7909cf6ec65c48664b093449ddee47f66d392
prerequisite-patch-id: 9f1d54b0f8c7b66fa21740a6dde491758a4e286d
prerequisite-patch-id: bac43d465cb205d355bdc4cb090a9636d7eab0bf
prerequisite-patch-id: 6878dba4d5b4682ac3c75a5fd4e218f7e437b952
prerequisite-patch-id: 60f558bffb5c82b391d033a98e001865a1c200e9
prerequisite-patch-id: 234536e42e7b3fbf0faf1aeb5270c1d382d2a308
prerequisite-patch-id: eddca3d5394d7c906429c5fc3dcd069c76b4f0e9
prerequisite-patch-id: fe15d4feee637598c6d584cadb2e9437e9b4c133
prerequisite-patch-id: 8bc5915890a404c326b2177492ee865186f13c52
prerequisite-patch-id: 513a9d8aa77a55bf36a7f9872c7907f86b0f49c5
prerequisite-patch-id: 04b21db217985f4d6854143c4c4816fbaec8b791
prerequisite-patch-id: a4c87b005cb54caeb43f796004fe7025b5423d65
prerequisite-patch-id: 51e0a54807c7a70d2a668eaf4fe7480bd6d1daec
prerequisite-patch-id: e0ae7b9ab1be84c45c88acf10a79ef79cbb161da
prerequisite-patch-id: f711794795acabcfd8ea64b668982260ee6f50fc
prerequisite-patch-id: c3fdfe64bd1d68ad2945e49617480e46052657c7
prerequisite-patch-id: 12e6fc40f66d1551793163ebd58959cbabe03914
prerequisite-patch-id: 3157e4c8b6b261c2875bdd41dddc9670690c050b
prerequisite-patch-id: 98230babe1be904e49accb786dd25664f341a301
prerequisite-patch-id: 8abf276b6c986a88b88a3c8ad1264434d9a2fdc4
prerequisite-patch-id: c2e9e2e8ea9c512de30937c8f5bd3d5ef4ffc79c
prerequisite-patch-id: 933b888ee73418bdac5cad130d3589ab58057492
prerequisite-patch-id: 290abfdc819f308d55af84a0da0e7711954a172c
prerequisite-patch-id: 5a6d3a718d972f3145ca538956992476e8e1f209
prerequisite-patch-id: 31c5dc4cbe6780ab4c58ab5d7539d1313202f578
prerequisite-patch-id: f2ab289cbc46e78b8c4ebd773f4448478f25a5b8
prerequisite-patch-id: 33fee4657b3063682b715560e75aee69cc1c6542
prerequisite-patch-id: 51e92202a61ae9ae2b9528448a4dd74248533759
prerequisite-patch-id: f28426ac55233f6ed9450332798b49d9f1564f57
prerequisite-patch-id: 3de49e04899037bbe846fabc3ebcd2ec347f7074
prerequisite-patch-id: 6bb5bb5b88eefe26a8c3f2a88ee75268402e6c33
prerequisite-patch-id: 55325d05b1f71ee22846fcc21b51aa7bd803097a
prerequisite-patch-id: d148a8f117d5d04ef6b04517f513629012ef850a
prerequisite-patch-id: 178be2f9d2e784ee9bf12a0f196176c115be9fbb
prerequisite-patch-id: 4d07ab25d78303866d0d97043ac7d3b3c89a188b
prerequisite-patch-id: 258aaf7fc047e39c606cfd78c6cb30ea0743ac4f
prerequisite-patch-id: af00c0c6ef1d1bbc867890c7e14ef486f9578cf7
prerequisite-patch-id: f8b3fbafeca752a548c9fc5405c224c3fab91506
prerequisite-patch-id: c400272e0d94987b176ab4d2920427ba55c4ebf6
prerequisite-patch-id: e4bcf2c1b962b45c87bd30a1d3f83c572156ae62
prerequisite-patch-id: f2b9793b2c244543fe34eab5c27909a2bfb62fd8
prerequisite-patch-id: f0bb74e8883d4127868f4584a6371027ec7f1b99
prerequisite-patch-id: 9fda2cc26a6c0ede913518edc7f3d0663a91e204
prerequisite-patch-id: 76736327d6e04674edb400ab901897e7f85848f7
prerequisite-patch-id: 663b6f9f32f308c22cd201a899359e545137164c
prerequisite-patch-id: bfe25db85aa783a0e28ab9d0b036ce9bf7c5664e
prerequisite-patch-id: 7f4e74be4224692341620a978d2306a776fcef72
prerequisite-patch-id: 501d31539b075804ed2457ffea8bfc62a3a0e741
prerequisite-patch-id: b398ab2567ab2f1a8ae9d38edbb9d79d21d79186
prerequisite-patch-id: 7aa50a42fe52f62e6049e1db7395196d4a13c1ef
prerequisite-patch-id: 70f01ccb6a002004c6e7e5e67f2851c9f6a751c6
prerequisite-patch-id: 55bc7159590c69b471be124aadacb8463600f4aa
prerequisite-patch-id: 5792cc3c66b195384f650433c9103beb91d3c581
prerequisite-patch-id: 98a3576a8b4bcb4f056d86d263cf23d7b8411b42
prerequisite-patch-id: e391c5ece2885b5e589bc711087d5a371a72ed3c
prerequisite-patch-id: a2f552f97c5722963a38caf4d7f902d62069550e
prerequisite-patch-id: 4ebcbc91d8988994d1a9d19622376b0bee2ac25e
prerequisite-patch-id: 85457481095d308cd9a0d2a9e54f627b515737be
prerequisite-patch-id: d5812c545f0d110f2ed7c0834bbe0d93162562bb
prerequisite-patch-id: 7350dc248055d177b3099bd08059d63e64b25b60
prerequisite-patch-id: 5f24411834075de3c079f4760de36f7fa514d1ec
prerequisite-patch-id: 2dea9538fe56b8c00615c0418c160cb354a05a52
prerequisite-patch-id: 7ddc6ba4e4bba68c3a70c391011b3ba37b191ca4
prerequisite-patch-id: 0fc220f5252f600e475689f9a5407b7e6153d6ae
prerequisite-patch-id: 5a66d4e456993fe13376403cb4c76df08c8dce08
prerequisite-patch-id: fbec227d8ae69f4d03b83c31f7109e00f0f71ff7
prerequisite-patch-id: a6b71b369cb47a90cb9b13e1e19c2dcc40500a23
prerequisite-patch-id: 7ccec7ae9dc1e473680c60f5715f7c337d25063f
prerequisite-patch-id: efd9cb34fbc605435637d8e8ffd5444dc546636e
prerequisite-patch-id: c3aa64dc59a5085221dcb5a7360525a7ca55f818
prerequisite-patch-id: 401d96e0485a847bce680a33743ad3e4957ef5ca
prerequisite-patch-id: e7809696dea41898fed3893a89a42e659d602001
prerequisite-patch-id: 7593f4f54732ee7c6f7398c92eb72d6df8a39c8e
prerequisite-patch-id: bff27cc61a42ae368012ac54ed3f270480311f91
prerequisite-patch-id: 2494c6b062aa5c085c64387316d899b7abec1d6a
prerequisite-patch-id: a9594faa7d8868cfdcf0fa858335f70869a0d770
prerequisite-patch-id: c9830b25135eebe9e29aab56ddc56f574ef69963
prerequisite-patch-id: e1ca45096cae5cf6af1eae5eb296e292d844e1cd
prerequisite-patch-id: f3a4100159f4439b5b5c0d6b6d8f1801009a942e
prerequisite-patch-id: ee6f83701b98c5905630c45c0d1a7248bc1ebb06
prerequisite-patch-id: 4299afb463aa53b56158d9c578038c9d3c34fa65
prerequisite-patch-id: 03c9a124f7f18071a1cd69bb58019d3cbfa02d44
prerequisite-patch-id: 8c9e4bf9b05ce417c46f030fba8ad94c402b43d4
prerequisite-patch-id: b72123408745b7ca5e830356dbf2f0c4c9e8f7f0
prerequisite-patch-id: a5f6dca1cd25b7acd10da55ba87fc16dfc0e83bd
prerequisite-patch-id: 539d868dd045bae18562347f0274c03ce067021a
prerequisite-patch-id: a0211ef7fad6369d0bd64f9d465783ef08cb3fbc
prerequisite-patch-id: 91e98f11cf1cc0b1f72e40770980f7bf446bf7df
prerequisite-patch-id: 90e16557722c5925bf3b8eba51bbb2af0f4302c5
prerequisite-patch-id: 433adc42677ecabda553a17d732a1a06b65822cd
prerequisite-patch-id: 2cfb033c2d9586444549f41d1cfffdcb5684a02d
prerequisite-patch-id: 5291c98633085e41123f0d550c9f1c9151cf70c6
prerequisite-patch-id: dc995be1d1670828b60a2767e3590b34265fa20b
prerequisite-patch-id: 415e4cf4850f841dbac8be802af83730b4bf0dbe
prerequisite-patch-id: d82bf3de7369d5b5ab36923d80730ad4dab47f08
prerequisite-patch-id: dd949452dada89bdabe829b6be83949bee32f6f9
prerequisite-patch-id: f96726d8a9c6f20e08b22252d886a83ee4e45733
prerequisite-patch-id: b5f640a17369199ef66ad110679975a1f98f661a
prerequisite-patch-id: e9accce6d3e0eb70a5c1c3a632518acf35a0a4d8
prerequisite-patch-id: ad492094c543a648266d56c29f7b216900b3c22e
prerequisite-patch-id: 33148f731b2f4e8bbcd3efdb4ad6eb640b7b8ac3
prerequisite-patch-id: e81f586f25440c8689cd1a3871101a6b01b06a84
prerequisite-patch-id: c4aef8d0dda5ba3372afb1b2fe0df83c691c55c1
prerequisite-patch-id: b07f9971a45607121c268313adbd83b3a7c4f8ea
prerequisite-patch-id: c23efa8f6cc8ab1d8838fa08d917c117fd07da17
prerequisite-patch-id: e667960c263805a1cfd92861b0827912e6667852
prerequisite-patch-id: 5a9630da075681a82051060514a68f2b6f2dfddc
prerequisite-patch-id: 73df7c3febda2d1c7f13d62880d48c3c51b15e6a
prerequisite-patch-id: 31960a10db3f4633af9ed63271c4c96dd06d9ecf
prerequisite-patch-id: f56a6e5539ea2b779e2793833a70b6258d84e861
prerequisite-patch-id: f180e2b9fce9901e4d806046c094d25e6ac4034e
prerequisite-patch-id: 55ae9acd86540828844f435b2f91139707234dbc
prerequisite-patch-id: 885dd9a28077e862606984138befb30453ca9b54
prerequisite-patch-id: 5da8d19a90ac474bef943d75c5536c00e6064fa1
prerequisite-patch-id: 1ded8902d727b23c46ee684294ccb8e694d0e3fc
prerequisite-patch-id: 2d5d2821afbd94cbb1d5ac4d027b22a548be7b6f
prerequisite-patch-id: 948adb211ec106bb3107ae39ae17997b79ed2443
prerequisite-patch-id: 770274e113a2ffff58cb9b8a68663fd7d1cddadc
prerequisite-patch-id: 13be492e491ce4c4f58042f64fcb94e725c64d35
prerequisite-patch-id: b56ef5a3b96409457826a3c661f0a755a7e26932
prerequisite-patch-id: 2e49a120deefe54341c142f1382ab951056fc891
prerequisite-patch-id: 29aee9cf98151394717c74447d29ae1b145e1853
prerequisite-patch-id: 94f28429ac370c1186c4adc593e624ff751b0766
prerequisite-patch-id: f2b9edd17ba2fc068b35aa788422aaaf12f6e564
prerequisite-patch-id: a638932a3d8580f5d0950904ad11d387f348fe1b
prerequisite-patch-id: e330b928eed5cf713775f44671052b5eeb992221
prerequisite-patch-id: 6a263fde34b8c4bdf298348c6982631880c153f5
prerequisite-patch-id: d3d0bd0568191724ac40b09d2312afa325f1e12c
prerequisite-patch-id: 108661725007625ac829df31775de85bcd507b5e
prerequisite-patch-id: 192c5f375065995eb4d4e63bfe9a33b04be72d18
prerequisite-patch-id: bc987b2156e2ac77241764c47c35b50590edd8df
prerequisite-patch-id: 7a0df14b16e523e09892820eb73ada8f11c258a0
prerequisite-patch-id: ad68eb823b37cddc5f03132a6759d1b64ff0e4c9
prerequisite-patch-id: d110160d27a8a1934d8413c66bfe3586d6b29e00
prerequisite-patch-id: 8381e804546223bb258717e45f814f7f68ac7fde
prerequisite-patch-id: 4ad9ed0ba0b6d0768fe4a7d022361562f290963f
prerequisite-patch-id: 6c029ef8c34f345bf3be5420b77eafa06be6b454
prerequisite-patch-id: c42758895496c31bec872e80709aa62df96ceb47
prerequisite-patch-id: e7ce65af76a20c6d43aace28c2a3b9f4c5e468ac
prerequisite-patch-id: 34d653dc7dbd4158f946c22f76051474eb8b316e
prerequisite-patch-id: 71dc997289525cbdf29501649da6c9cc1604c899
prerequisite-patch-id: 42211b6efe70a1f73bab78ffb747ad3b28bcd628
prerequisite-patch-id: 96a88c31bd365b0cdac4a6b280e5d2edf4e326fa
prerequisite-patch-id: 4869e65e7b976ec0ab6725fb6a437eeb113cbf9b
prerequisite-patch-id: c9fb7e121e8ed0f8b94f6da58f388c5ecc3d2a5a
prerequisite-patch-id: 27127ead8db18658af1bad60c7ec36c566edcef6
prerequisite-patch-id: 7e7115dac2ec5b0c68e19f2a133af0eddd3d5328
prerequisite-patch-id: fd0499eb84c477a1546fc096decfa66818cee19e
prerequisite-patch-id: feb1c7d7953d28e6a6c3182fb7c7e24fc62c370b
prerequisite-patch-id: a2c986457483964d0e93ccecfa1b76c1f5c82950
prerequisite-patch-id: 94fca83692ee35a7e39c0ec8acf92dd7f0d4722e
prerequisite-patch-id: 8e60d05c540142d2aa4637c1ec40457c83903e68
prerequisite-patch-id: f8beaa5cd738491556d1ebeb71a98735d7aeefda
prerequisite-patch-id: c65ad295b68c43dd2a9ec8506cb7de6fe6f0fc01
prerequisite-patch-id: f2276081575251ecacc663e5e59e1b4f9d2bfef3
prerequisite-patch-id: de80081f7f8a535635f1f27aa285329a17903478
prerequisite-patch-id: f7b9d17a5d5e0d413103d9d6ec70af0bea51e8d1
prerequisite-patch-id: 5f45273f6aef6385bfe1b13aea024652070d1b05
prerequisite-patch-id: 384fc81df1c5fc6530c1948e5fda314bde8e83de
prerequisite-patch-id: 0b0043afdca53937c0bcb8988e4e9a0d22a3f169
prerequisite-patch-id: 0c6e5004230a9361dfd182389405bb90797e3fcd
prerequisite-patch-id: 1e0f9c6d010379abad504a19070619938e5d3ee0
prerequisite-patch-id: 37894f19e303c699b1c1d8a53147c8dd26c8f93d
prerequisite-patch-id: 06f72b214062652208a584949a7b350e76eb8706
prerequisite-patch-id: 5e9dc37268a36976efbf27d2d0a8e07e016f4155
prerequisite-patch-id: d16a275e026b8cbe7d5a07dd2bc5b0adcc83acd9
prerequisite-patch-id: fbbc75a2a56581442aef04cbeb899e988211ebeb
prerequisite-patch-id: fc16fd475e11d00e4d608799073871ae5ea6891c
prerequisite-patch-id: 1bb780dca6f45fbd81a8a653501740211ca0de8d
prerequisite-patch-id: d02a5f17da2e3d962b82e580f1a4ff1044db45ba
prerequisite-patch-id: bda5c98a027408b279612ab626344ae474596557
prerequisite-patch-id: f8cf7f46cd8ac4575f3a4b3646144d7754683e75
prerequisite-patch-id: 46f80332efc0c43e2c1c5414d3c09a1cd3933deb
prerequisite-patch-id: 97fea256019a87c20c43999bfcf470256e4e2a3c
prerequisite-patch-id: 5f090920520ec2097756580b04d345d3d6b0234d
prerequisite-patch-id: d171fb971e851712fc6de2eac490a3b8ac42ddf3
prerequisite-patch-id: f2dd3d65b871dadcf246267b0b07a5e06cef9c58
prerequisite-patch-id: 780e8c357ec4a1cbf2dd4b44f3373b835524ebc8
prerequisite-patch-id: c78b99ceaad692f1ddfaeb0a11c9e22b9f44ad3f
prerequisite-patch-id: 3eb25721a94358b64c1b6d8078c3d96cd7a28259
prerequisite-patch-id: f5825fe5ff82cbaed077372d6a817b505c6cf616
prerequisite-patch-id: b7f2a9338ce86b064ebabddd434a10cb13de44f3
prerequisite-patch-id: b95eb0ed353c45455549940bca877bdaafd2a4a4
prerequisite-patch-id: ffc791b1363c6a51e6396cdcda120cb5f8478cbc
prerequisite-patch-id: 80da78bdf449a377f5000e8b7baee340e4f3f875
prerequisite-patch-id: f9aa1f1dd697a0459839a4a19e7615a9a889ec11
prerequisite-patch-id: 445a435ebb64dbe0199861856c7b329658feba2c
prerequisite-patch-id: 6ea1dc96cd7ac6908e2f4929dc66524daed618e1
prerequisite-patch-id: 4fa9bbee982bd91be516d823b0f6720c66d140e7
prerequisite-patch-id: 2c937bcb4e0bc5dfc53d6de1073957611c39d532
prerequisite-patch-id: 0df77ab4ad27b776d32b5ec17e53514ac9674770
prerequisite-patch-id: e288d7a5d47b450f2b94459be58b809b0f9b078e
prerequisite-patch-id: 94b952556ff3e4a0b78f53f634316c190806865b
prerequisite-patch-id: 964eb9cbe3c11a824a079aa4553a4148d7aeefe1
prerequisite-patch-id: 5630636c889e6729d3a06ed40b6f71754181e775
prerequisite-patch-id: ac6d19ecd00dfaf3130afbc5c3e617f247b4a6e4
prerequisite-patch-id: 90ebaba65e3bd3fc755ccecb88143f08c6021d5b
prerequisite-patch-id: 6bce5e77f54665611a7f102236d8971c29a55811
prerequisite-patch-id: 627cf03a16fc670dc7ef79648e53f1110d0a5b3c
prerequisite-patch-id: b3ee7401af24bce059844db29122567023d82692
prerequisite-patch-id: 36f8b692e7091a75843e51a951d4f756bb6c28f9
prerequisite-patch-id: 3e99e1ea90b047c495faecdc32ccb4beb52e0129
prerequisite-patch-id: 9a11a68e5130a7bd45f43a3ee3f7ca9f1a47b9ec
prerequisite-patch-id: 2cbbe3b9e779ded103b6e89fb7e5f3910b2325b8
prerequisite-patch-id: e6c1316f4522e60a59f0933e80d09e06103957e7
prerequisite-patch-id: 7ee16d0c85b43265f1b056049a01025c7810232c
prerequisite-patch-id: 6b8269c12ad69a6a21c1120fe82c67a7b8ee9acf
prerequisite-patch-id: 12ee8958463c04777e0a16a240abb35983738b07
prerequisite-patch-id: 740c1a5a0b892b48878bc781c236d08714a41433
prerequisite-patch-id: e8599f48107a755966118fe64d849cb43c50dc2c
prerequisite-patch-id: 81f166fbeecde2009eefeecddd531df283a5fcc6
prerequisite-patch-id: cc4a57a25ddc2617ba71db0ebaf6e0af2d3052eb
prerequisite-patch-id: 3e27607b2266f41ac8003b54cbcd6b728f0a5126
prerequisite-patch-id: 4a2bb845ad966d46d7336ec6ff19ef2d62b5da6e
prerequisite-patch-id: 9adbe85a6c15f19ce1e06249aba9132a74e00ef9
prerequisite-patch-id: 4815a0599d2bf307922dc354ebe34d1e4addbf70
prerequisite-patch-id: fb0dc6819628e7f54bcf63364d7b307fe8ec1156
prerequisite-patch-id: 0439fe082b8672e56656d46b2372265901f8f4b0
prerequisite-patch-id: 93c662429f23352abd506ec7dee84e7501cb7003
prerequisite-patch-id: c1be059977523866bab25cf52494bdba5987e320
prerequisite-patch-id: c3c17024d74d7dce90b8f5a8b51c74ff60d71854
prerequisite-patch-id: 26c7ed441739dfae6fa040bf5522f4902ccfd11d
prerequisite-patch-id: d850be41b9545b1cbaa1b2e94b9e38e2b0ad9097
prerequisite-patch-id: 1545666b70dc2f0ddb4e8a69eb0b0f806f2f99c9
prerequisite-patch-id: da57df9bd52ef96146972ba965f92614b17e900a
prerequisite-patch-id: c530fa97c29d55e8b3af61874aaaf75fcf6350cf
prerequisite-patch-id: c6cab7c964c6cd20692ff897681ef7205e16ad1f
prerequisite-patch-id: 80c97d8111142734101065ac27a936eb217e9ba0
prerequisite-patch-id: 60df13f6d61841699e205e6bceeac2befc66a7c9
prerequisite-patch-id: a88877747953f3f4f2b9c373adb7fe102e1b4a10
prerequisite-patch-id: 0805e5bd4b8aecc99da0f926b7746596db920131
prerequisite-patch-id: cced22a6bdddf0d220b3c7a74f134be6af5481a3
prerequisite-patch-id: 894ea786e3369867208da33326ceed209d0c8cd8
prerequisite-patch-id: 28959c8b4ce26b4d9fbceb1142e7d137e7de9653
prerequisite-patch-id: 388540d111eb3e9a62e2da5af1454cea0ff4458c
prerequisite-patch-id: 635000fc05f2495a713c19feda0418a9ba8a2fbe
prerequisite-patch-id: 7714f4da8c917a342aed5368414c861e6e4e8122
prerequisite-patch-id: 31a36616146432b73218caca85a8a4217c94bbe1
prerequisite-patch-id: 32977b260ddd91dd3fa4d19bba590a4ed9f2ed17
prerequisite-patch-id: ecf5e93a7e213f873e9ce2a940bab7ed496bb035
prerequisite-patch-id: 7c11e5ade8c578e873d13c19cf5cfe8e6431e935
prerequisite-patch-id: 718ce12944c4b531bd91a6773ac7724775fffed5
prerequisite-patch-id: dc3e766fdea5880cb9088dc732c0ca4d9875acd6
prerequisite-patch-id: 30fadb1be39747ece404af2b363304e46bb37a20
prerequisite-patch-id: 197ced07a9d27af482fc12f65f2e581c7702b35b
prerequisite-patch-id: 94b821b299bad48bdafe5c353aa13b54652b1c7b
prerequisite-patch-id: d306cccf4c2f2c7ffd2ce40c20c43038063f4745
prerequisite-patch-id: 377e0abd739810f77700cb414f89734852f7bd6a
prerequisite-patch-id: e55a394f00e11961b5b86275f38e3d04b8b840dc
prerequisite-patch-id: 0015d41d8ee603c26e8c6002a9846ff457659837
prerequisite-patch-id: ffc3be872ab86dd0abcd952c56f1db81f6712e1b
prerequisite-patch-id: 970f9aae71cf61845d5a13254b79ece87cc7bb0d
prerequisite-patch-id: 494b5ae6c5c001059a2221e2ee32791968927490
prerequisite-patch-id: 4178ee66a342080459bd9d5f8f704dfef4bc3ce8
prerequisite-patch-id: eecb24d438a1464dab50f5a4f05e6bed0f5e4eec
prerequisite-patch-id: 6846ea276355004237b83cf217df2c7adc1825c7
prerequisite-patch-id: b5e8dcfd46e50793e6e078cb2547155687d88f41
prerequisite-patch-id: ca75ac68b698bb81c800225f7f29c879575e2739
prerequisite-patch-id: 7c3e6130a1166e38b7fee4de199086a14c4d2dae
prerequisite-patch-id: 29fe9dcf5fdaebbd21dc3808d4e29a484437f76f
prerequisite-patch-id: c2efdbc65a58e6cb0b0849eafe68d63384894ab4
prerequisite-patch-id: b55efe888337e41ad6da69a7cef27e6b6cb3240d
prerequisite-patch-id: 2fd49d7242380409be7b0d55e75ee6831bb3250d
prerequisite-patch-id: d7dd17bab97aa9d82d6e9854a8443214d0a79cc0
prerequisite-patch-id: 6d7e2aff632c86c361a31dde439a349c3d3ed088
prerequisite-patch-id: f405c19b0e47d5dd4fda214775330d0ec45e41f3
prerequisite-patch-id: 16be799a040d666af7f63c7fd814e6d7a0a9cbc3
prerequisite-patch-id: 68f97968cc6f93076fe268046695dc27aae8c872
prerequisite-patch-id: 2dcafb4a5a1cc5d1ff19bc89c8ea2e6043c6bc0c
prerequisite-patch-id: 041b35d9a58ef08726b294107f68fd3a09371d40
prerequisite-patch-id: 61e034d50d94a8734cc09823374bf8ec222f4f7a
prerequisite-patch-id: ed312bf0ad0e3cef97c7453daf1809f93d394d73
prerequisite-patch-id: 943b011cff282761112668160999174acc7af13d
prerequisite-patch-id: c180d412f74ec39f5f543fb952032731d4857c59
prerequisite-patch-id: 2d7408b4f9b055b821200f3db9a0aa729c3c5174
prerequisite-patch-id: 970c8ea0756a7e074492d909dcacfb1ec01633f8
prerequisite-patch-id: 8e2909165deacb734c4262b7f4992b11db79ca8e
prerequisite-patch-id: a1fad911931dc8fa6d66c3e484af4b1b47db7e27
prerequisite-patch-id: 3d16b0c5496caf737905b3e7360abd572a126b59
prerequisite-patch-id: 569111b24492f5a5312af773637c2707a8bddf56
prerequisite-patch-id: bb20a1531e9f8d185af6318c4a732dcc6dac233d
prerequisite-patch-id: 7c74a3eeeccfbe95391cb217036eb40a0fb530ca
prerequisite-patch-id: f6f358f6588ef79cf534b40cbcb30cbacc980103
prerequisite-patch-id: 782e2b3bb33d6eef727153dd1ee0a5ea4315a12f
prerequisite-patch-id: aa20a0829a38c1895965d710fabc7fe0abc347e0
prerequisite-patch-id: 4cbc274121eae0e459e6a124a22d8ce88df20131
prerequisite-patch-id: b23f4948553aef67c076eaa325e5e0b7a5f2c1da
prerequisite-patch-id: 4d4bf84905888fd11c7a930cd5509e6338e267d0
prerequisite-patch-id: 8ff3fb6a70d11fa44fbfb6d8104f8d6342776bce
prerequisite-patch-id: f84360484f25d4c89c84cbae4e24480d678fc3af
prerequisite-patch-id: 82e5c78d79c38544d981c12061b4ec8472f52cda
prerequisite-patch-id: 5ce0a464aad28369d64c3f4d8aa0be72b7742762
prerequisite-patch-id: ac12670e3ce92a929573f5c238813f4113e660b1
prerequisite-patch-id: dfd0e61c59c3bff4240eccd64d67349fb94db702
prerequisite-patch-id: ba8126f93d27a3f75d491903a0db0afa47e9aaf3
prerequisite-patch-id: 22fd9e963456849a347eebd7d7d29e9d6494dd83
prerequisite-patch-id: 6bf172a381047e57d8bb6a9e9318a557c45ed168
prerequisite-patch-id: f5a47df5e9e1f5de656e3be94398e5ec3dae13a6
prerequisite-patch-id: 13d23a2bae7fe101a4cfe26ad819e4b69c3a3fd1
prerequisite-patch-id: 7d89969659b1c4302ee85fc1af8946c606fed8b5
prerequisite-patch-id: 090c3867aed79676f7a834c0386f8a58bfdd1637
prerequisite-patch-id: c7fc71bfafbebb2f959ff20c47e26044fe7f19b0
prerequisite-patch-id: 0d7ad9ab25092ce6ee2ccd811afd7fbe942ab884
prerequisite-patch-id: f5f0a21a6851612c44aaa2085d5d0a8d55196ea2
prerequisite-patch-id: 8898b37da960a6a80d1e502f8832725fbc931e66
prerequisite-patch-id: cab54c88e681f278653473f52f5ac959c477bc91
prerequisite-patch-id: c9f1afce0bda5bb342d8093b52494a747431a570
prerequisite-patch-id: 9b6b2dc99d68c0be4c720c17ccc68aa15f9b9451
prerequisite-patch-id: 0dc0e8966cd1a2078ebb9da49edebf532dc7446f
prerequisite-patch-id: 7637c825844cd60aa1590feb2ea7b0fe77a17b4f
prerequisite-patch-id: 06eda91ddc94cd022a281c1b0b4c63733c59eb45
prerequisite-patch-id: 8c38dd58ac75431cda8fec7795d4a8a230a9ad8f
prerequisite-patch-id: 9e2bc70598401f7859cc95ca55f414354c9507c5
prerequisite-patch-id: 537eeb5f8dbdb1e9ae70c417fb997e4ec023dac6
prerequisite-patch-id: 9a7d86f21f750a8c57ee50f861be9ab1050f9505
prerequisite-patch-id: ad2c8fcefd5c9bc21412bbb180b4295a16ec1879
prerequisite-patch-id: 5026d233b36f8c8e4f01026b4c971a967eb92c60
prerequisite-patch-id: 3ca52657bfe9a876d071531135b79187059d24c2
prerequisite-patch-id: eafbe0613b7df9b84354be9c04511f244f5c9f87
prerequisite-patch-id: 4e74f1931beb23e132c537abefe9f535eae183dd
prerequisite-patch-id: e76ad1d11e17da09fd85b2001096f32583a2cb08
prerequisite-patch-id: 32b73c61663f04e94a92d897491431f63480040f
prerequisite-patch-id: 1538dc530f0603257a29c85d8b62853684edf8a6
prerequisite-patch-id: dd6095d01e0cbb6c36a8a0b51c0cca60f6aa4013
prerequisite-patch-id: 1ec872e29bc960808803c3eaca048b6908bf286c
prerequisite-patch-id: 9bd65ebad6f6a171fab1ec39728bdc6657cec586
prerequisite-patch-id: b2526d0cb8f1a685ae96d53f8ecc7b009a09d1e0
prerequisite-patch-id: 3acbdc1d9c60a9c1cac000bdacdf37b96c46381b
prerequisite-patch-id: 803340f89adcccf0e03033bb08ba88f5a653dad2
prerequisite-patch-id: 92f424fc54cb822bfbfdfa19614d76f94a9b4661
prerequisite-patch-id: f24f89270ab6572f7755625ee7b78ee994969644
prerequisite-patch-id: 92c131d7039e57f497593b94fea2c1179fc41082
prerequisite-patch-id: 2691e13e4c4a7e8f4f9a016362b5c5da32f228a8
prerequisite-patch-id: 32639d92b2a91407959c009dde791cd716c55602
prerequisite-patch-id: 5c299a8d485158d9c7cfcf70cca44358882dd11a
prerequisite-patch-id: d64db60493d9a0ab0f9b4bd4d1e09bbe167fcb34
prerequisite-patch-id: d8fe797e2cf1d703af242f1866fea2f14711f039
prerequisite-patch-id: f30183e548ab78cbf35ecb62acb985c14a37b8de
prerequisite-patch-id: b0b1b9ca0b8aa702e5d5a22f9590f014b5617897
prerequisite-patch-id: 9d7980562badfd04c5a4e86a3dc64f49fbc4aaeb
prerequisite-patch-id: 817872422d9b06ee466470d08e4db4f201d69e43
-- 
2.32.0.255.gd9b1d14a2a

