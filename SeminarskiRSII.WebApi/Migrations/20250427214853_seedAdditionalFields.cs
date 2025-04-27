using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class seedAdditionalFields : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "DatumRegistracije", "Status" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true });

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "DatumRegistracije", "Status" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true });

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 3,
                column: "DatumRegistracije",
                value: new DateTime(2025, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 4,
                column: "DatumRegistracije",
                value: new DateTime(2025, 4, 4, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 5,
                columns: new[] { "DatumRegistracije", "Status" },
                values: new object[] { new DateTime(2024, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified), true });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "DatumRegistracije", "Status" },
                values: new object[] { new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false });

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "DatumRegistracije", "Status" },
                values: new object[] { new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false });

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 3,
                column: "DatumRegistracije",
                value: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 4,
                column: "DatumRegistracije",
                value: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "gost",
                keyColumn: "ID",
                keyValue: 5,
                columns: new[] { "DatumRegistracije", "Status" },
                values: new object[] { new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), false });
        }
    }
}
